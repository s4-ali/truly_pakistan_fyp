//
//
//import 'models/ad_model.dart';
//import 'models/category_model.dart';
//import 'models/page_model.dart';
//
//List<String> images = [
//  "assets/image_04.jpg",
//  "assets/image_03.jpg",
//  "assets/image_02.jpg",
//  "assets/image_01.png",
//];
//
//List<String> title = [
//  "Hounted Ground",
//  "Fallen In Love",
//  "The Dreaming Moon",
//  "Jack the Persian and the Black Castel",
//];
//
//List<AdModel> adModels = [
//  AdModel("Trip To Swat","10,000","https://media-cdn.tripadvisor.com/media/photo-m/1280/19/67/88/93/swat-valley.jpg"),
//  AdModel("Malam Jabba 2 Days Trip","12,000","https://i0.wp.com/www.destinations.com.pk/wp-content/uploads/2017/06/Malam_Jabba_Ski_Resort.jpg?fit=1024%2C768"),
//  AdModel("Moola Chatuk Balochistan","12,599","https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Moola_Chotuk_Hidden_paradise_in_Balochistan.jpg/1280px-Moola_Chotuk_Hidden_paradise_in_Balochistan.jpg"),
//  AdModel("3 Days trip to Ushu Forest","9,999","https://i2.wp.com/wander-lush.org/wp-content/uploads/2020/01/PassuConesPakistanSuthidaloedchaiyapanCanvaPro.jpg?w=784&ssl=1"),
//  AdModel("One Day Trip To Eagles Nest","10,000","https://i0.wp.com/wander-lush.org/wp-content/uploads/2020/01/YarkhunValleySamanthaIntentionalDetours.jpg?w=784&ssl=1"),
//  AdModel("One Day Trip to Shah Jahan Mosque","12,000","https://i1.wp.com/wander-lush.org/wp-content/uploads/2020/01/ShahJahanMosqueMuhammadFarooqCanvaPro.jpg?w=784&ssl=1"),
//  AdModel("7 Days trip To Fairy Meadows","12,599","https://i0.wp.com/wander-lush.org/wp-content/uploads/2020/01/FairyMeadowsPakistanPatrickPoendlCanvaPro.jpg?w=784&ssl=1"),
//  AdModel("Rakaposhi Basecamp hike","95,000","https://i2.wp.com/wander-lush.org/wp-content/uploads/2020/01/RakaposhiMountainPakistanSkazzjyCanvaPro.jpg?w=784&ssl=1"),
//];
//
//PageModel mainPageModel= PageModel(
//    pageTitle: "MarketPlace",
//    featuredItems: adModels,
//    categories: [
//      CategoryModel(categoryTitle: "Services", categoryAds: adModels),
//      CategoryModel(categoryTitle: "Goods", categoryAds: adModels),
//    ],
//    adsList: adModels
//);
//PageModel servicesPageModel= PageModel(
//    pageTitle: "Services",
//    featuredItems: adModels,
//    categories: [
//      CategoryModel(categoryTitle: "Hotels", categoryAds: adModels),
//      CategoryModel(categoryTitle: "Transport", categoryAds: adModels),
//      CategoryModel(categoryTitle: "Travel Agencies", categoryAds: adModels),
//    ],
//    adsList: adModels
//);
//PageModel goodsPageModel= PageModel(
//    pageTitle: "Goods",
//    featuredItems: adModels,
//    categories: [
//      CategoryModel(categoryTitle: "Clothing", categoryAds: adModels),
//      CategoryModel(categoryTitle: "Equipments", categoryAds: adModels),
//    ],
//    adsList: adModels
//);