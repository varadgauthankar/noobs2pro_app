const String baseUrl = 'noobs2pro.com';

const String allPostsEndpoint = 'wp-json/wp/v2/posts';

const String categories = 'wp-json/wp/v2/categories';

const String getPostsByCategoryId =
    '/posts?per_page=100&categories='; //give category id after =

const String searchArticles = '/posts?search=ios&_embed';

const Map<String, dynamic> perPage100 = {'per_page': '100', '_embed': ''};
