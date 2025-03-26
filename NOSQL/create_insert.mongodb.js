
use('bookstore');

db.createCollection('book_details');
db.createCollection('user_activity');

db.book_details.insertMany([
  {
    "book_id": 1,
    "full_description": "In a hole in the ground there lived a hobbit... This beloved fantasy classic follows Bilbo Baggins on his unexpected adventure.",
    "reviews": [
      { "author": "Reader123", "rating": 5, "text": "A timeless classic!" },
      { "author": "FantasyFan", "rating": 4, "text": "Enjoyable read for all ages." }
    ],
    "author_biography": "J.R.R. Tolkien was an English writer, poet, philologist, and academic, best known as the author of the classic high fantasy works The Hobbit and The Lord of the Rings.",
    "related_books": [2, 4, 7],
    "tags": ["fantasy", "adventure", "hobbit", "middle-earth"]
  },
  {
    "book_id": 2,
    "full_description": "The first volume of The Lord of the Rings trilogy, where the epic quest to destroy the One Ring begins.",
    "reviews": [
      { "author": "RingBearer", "rating": 5, "text": "A masterpiece of fantasy literature." }
    ],
    "author_biography": "...",
    "related_books": [1, 4, 7],
    "tags": ["fantasy", "epic", "lord of the rings", "middle-earth"]
  },
  {
    "book_id": 3,
    "full_description": "The second book in the Lord of the Rings trilogy...",
    "reviews": [],
    "author_biography": "...",
    "related_books": [1, 2, 4],
    "tags": ["fantasy", "epic", "lord of the rings", "middle-earth"]
  },
  {
    "book_id": 4,
    "full_description": "The climactic conclusion to the Lord of the Rings...",
    "reviews": [
      { "author": "LastKing", "rating": 5, "text": "A satisfying end to an incredible journey." }
    ],
    "author_biography": "...",
    "related_books": [1, 2, 3],
    "tags": ["fantasy", "epic", "lord of the rings", "middle-earth"]
  },
  {
    "book_id": 5,
    "full_description": "The epic saga of Westeros begins with political intrigue and the looming threat of winter.",
    "reviews": [
      { "author": "WesterosFan", "rating": 5, "text": "Compelling characters and a gripping plot." }
    ],
    "author_biography": "George R.R. Martin is an American novelist and short-story writer of fantasy, horror, and science fiction.",
    "related_books": [6, 7],
    "tags": ["fantasy", "game of thrones", "westeros", "political intrigue"]
  },
  {
    "book_id": 6,
    "full_description": "The second volume in A Song of Ice and Fire...",
    "reviews": [],
    "author_biography": "...",
    "related_books": [5, 7],
    "tags": ["fantasy", "game of thrones", "westeros", "war"]
  },
  {
    "book_id": 7,
    "full_description": "The third book in the A Song of Ice and Fire series...",
    "reviews": [
      { "author": "DragonQueen", "rating": 4, "text": "Full of twists and turns." }
    ],
    "author_biography": "...",
    "related_books": [5, 6],
    "tags": ["fantasy", "game of thrones", "westeros", "dragons"]
  },
  {
    "book_id": 8,
    "full_description": "A beloved classic exploring the complexities of love and society in 19th-century England.",
    "reviews": [
      { "author": "ClassicReader", "rating": 5, "text": "A beautifully written novel." }
    ],
    "author_biography": "Jane Austen was an English novelist whose works of social commentary have earned her place as one of the most widely read writers in English literature.",
    "related_books": [9],
    "tags": ["romance", "classic", "19th century", "england"]
  },
  {
    "book_id": 9,
    "full_description": "Another delightful novel by Jane Austen...",
    "reviews": [],
    "author_biography": "...",
    "related_books": [8],
    "tags": ["romance", "classic", "19th century", "england"]
  },
  {
    "book_id": 10,
    "full_description": "Ten strangers are lured to an isolated island mansion, where they are systematically killed off one by one.",
    "reviews": [
      { "author": "MysteryLover", "rating": 5, "text": "A brilliant and suspenseful mystery." }
    ],
    "author_biography": "Agatha Christie was an English writer known for her sixty-six detective novels and fourteen short story collections.",
    "related_books": [],
    "tags": ["mystery", "thriller", "agatha christie", "island"]
  }
]);


db.user_activity.insertMany([
  {
    "user_id": 1,
    "session_id": "abc123xyz",
    "timestamp": "2025-03-26T10:00:00Z",
    "event_type": "view_book",
    "details": { "book_id": 1 },
    "ip_address": "192.168.1.10",
    "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
  },
  {
    "user_id": 2,
    "session_id": "def456uvw",
    "timestamp": "2025-03-26T10:05:00Z",
    "event_type": "search_term",
    "details": { "search_query": "fantasy books" },
    "ip_address": "10.0.1.5",
    "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
  },
  {
    "user_id": 1,
    "session_id": "abc123xyz",
    "timestamp": "2025-03-26T10:10:00Z",
    "event_type": "add_to_cart",
    "details": { "format_id": 2, "quantity": 1 },
    "ip_address": "192.168.1.10",
    "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
  },
  {
    "user_id": 3,
    "session_id": "ghi789rst",
    "timestamp": "2025-03-26T10:15:00Z",
    "event_type": "view_book",
    "details": { "book_id": 8 },
    "ip_address": "172.16.0.20",
    "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_5 like Mac OS X)"
  },
  {
    "user_id": 2,
    "session_id": "def456uvw",
    "timestamp": "2025-03-26T10:20:00Z",
    "event_type": "view_book",
    "details": { "book_id": 5 },
    "ip_address": "10.0.1.5",
    "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
  },
  {
    "user_id": 1,
    "session_id": "abc123xyz",
    "timestamp": "2025-03-26T10:25:00Z",
    "event_type": "checkout_started",
    "details": {},
    "ip_address": "192.168.1.10",
    "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
  },
  {
    "user_id": 3,
    "session_id": "ghi789rst",
    "timestamp": "2025-03-26T10:30:00Z",
    "event_type": "add_to_cart",
    "details": { "format_id": 16, "quantity": 2 },
    "ip_address": "172.16.0.20",
    "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_5 like Mac OS X)"
  },
  {
    "user_id": 4,
    "session_id": "jkl012mno",
    "timestamp": "2025-03-26T10:35:00Z",
    "event_type": "view_book",
    "details": { "book_id": 10 },
    "ip_address": "192.168.2.15",
    "user_agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64)"
  },
  {
    "user_id": 2,
    "session_id": "def456uvw",
    "timestamp": "2025-03-26T10:40:00Z",
    "event_type": "order_placed",
    "details": { "order_id": 1 },
    "ip_address": "10.0.1.5",
    "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
  },
  {
    "user_id": 1,
    "session_id": "abc123xyz",
    "timestamp": "2025-03-26T10:45:00Z",
    "event_type": "remove_from_cart",
    "details": { "format_id": 2 },
    "ip_address": "192.168.1.10",
    "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
  },
  {
    "user_id": 4,
    "session_id": "jkl012mno",
    "timestamp": "2025-03-26T10:50:00Z",
    "event_type": "add_to_cart",
    "details": { "format_id": 29, "quantity": 1 },
    "ip_address": "192.168.2.15",
    "user_agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64)"
  },
  {
    "user_id": 5,
    "session_id": "pqr345stu",
    "timestamp": "2025-03-26T10:55:00Z",
    "event_type": "view_book",
    "details": { "book_id": 6 },
    "ip_address": "172.16.1.30",
    "user_agent": "Mozilla/5.0 (Linux; Android 10)"
  }
]);