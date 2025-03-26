
CALL GetBooksByGenreAndPublisher('Fantasy', 'Houghton Mifflin Harcourt');
CALL GetBooksByGenreAndPublisher('Romance', 'Penguin Classics');
CALL GetBooksByGenreAndPublisher('Thriller', 'Bantam Books');

CALL GetOrdersByCustomerID(1);
CALL GetOrdersByCustomerID(2);

CALL GetAveragePriceByFormatAndGenre('Paperback', 'Fantasy');
CALL GetAveragePriceByFormatAndGenre('Ebook', 'Romance');
CALL GetAveragePriceByFormatAndGenre('Hardcover', 'Mystery');

CALL GetTopNPopularBooks(1);
CALL GetTopNPopularBooks(5);
