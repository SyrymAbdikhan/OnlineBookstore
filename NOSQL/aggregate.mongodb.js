
use('bookstore');

// ======== Book Details Collection ========

// counting how many books have and dont have reviews
db.book_details.aggregate([
  {
    "$addFields": {
      "has_reviews": { "$gt": [ { "$size": "$reviews" }, 0 ] }
    }
  },
  {
    "$group": {
      "_id": "$has_reviews",
      "count": { "$sum": 1 }
    }
  }
]);

// getting books that have reviews
db.book_details.find(
  {
    "reviews": {
      "$exists": true,
      "$not": { "$size": 0 }
    }
  },
  {
    "_id": 0,
    "book_id": 1,
  }
);

// getting book with highest average rating
db.book_details.aggregate([
  {
    "$unwind": "$reviews"
  },
  {
    "$group": {
      "_id": "$book_id",
      "average_rating": { "$avg": "$reviews.rating" }
    }
  },
  {
    "$sort": { "average_rating": -1 }
  }
]);

// getting common tags used across all books
db.book_details.aggregate([
  { "$unwind": "$tags" },
  { "$group": { "_id": "$tags", "count": { "$sum": 1 } } },
  { "$sort": { "count": -1 } },
  { "$limit": 5 }
]);


// ======== User Activity Collection ========

// sequence of events for a specific session
db.user_activity.find(
  { "session_id": "abc123xyz" },
  { "user_id": 1, "event_type": 1, "details": 1, "timestamp": 1}
).sort({ "timestamp": 1 });

// number of times each book has been viewed
db.user_activity.aggregate([
  { "$match": { "event_type": "view_book" } },
  { "$group": { "_id": "$details.book_id", "view_count": { "$sum": 1 } } },
  { "$sort": { "view_count": -1 } }
]);

// most frequent search terms
db.user_activity.aggregate([
  { "$match": { "event_type": "search_term" } },
  { "$group": { "_id": "$details.search_query", "search_count": { "$sum": 1 } } },
  { "$sort": { "search_count": -1 } },
  { "$limit": 10 }
]);

// find user ids who viewed a book and added it to the cart within the same session
db.user_activity.aggregate([
  { // getting only view_book and add_to_cart event types
    "$match": {
      "$or": [
        { "event_type": "view_book", "details.book_id": 1 },
        { "event_type": "add_to_cart", "details.format_id": { "$exists": true } }
      ]
    }
  },
  {
    "$group": {
      "_id": "$session_id",
      "events": { "$push": "$$ROOT" }
    }
  },
  { // getting documents only if it has view_book and add_to_cart
    "$match": {
      "$and": [
        { "events.event_type": "view_book", "events.details.book_id": { "$exists": true } },
        { "events.event_type": "add_to_cart", "events.details.format_id": { "$exists": true } }
      ]
    }
  },
  { "$unwind": "$events" },
  { // getting only add_to_cart to count view_book and add_to_cart as one
    "$match": {
      "events.event_type": "add_to_cart",
      "events.details.format_id": { "$exists": true }
    }
  },
  { // grouping by user_id and counting number of actions
    "$group": {
      "_id": "$events.user_id",
      "count": {"$sum": 1}
    }
  }
]);
