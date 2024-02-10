import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technupur_test/api_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<String> bottomImages = [
    'assets/images/home.png',
    'assets/images/category.png',
    'assets/images/cart.png',
    'assets/images/wishlist.png',
    'assets/images/user.png',
  ];




  int _selectedIndex = 0;
  
  
  
  calculateDiscountPrice(double price , double discountPercentage){
    return price - (price * discountPercentage)/100;
  }


  @override
  void initState() {
    var apiVm = Provider.of<ApiProvider>(context , listen: false);
     apiVm.getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiVm  , child) {
        return Scaffold(
         bottomSheet:  buildBottomSheet(),
          body: SafeArea(
            child:
                apiVm.isLoading==true?const Center(child: CircularProgressIndicator(),):
            SingleChildScrollView(
              child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8.0),
                           color: const Color(0xffF0F6F8),
                         ),
                         child: Image.asset('assets/images/drawer.png' , scale: 3,),
                       ),
                       Image.asset('assets/images/Logo2.png' , scale: 4,),
                       const Icon(Icons.search),

                     ],
                   ),
                 ),
                  const SizedBox(height: 10,),
                 const Divider(
                   thickness: 2,
                 ),
                  const SizedBox(height: 10,),
                 SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 16.0),
                     child: Row(
                       children: List.generate( apiVm.productModelList?.length??0 , (index) {
                         return Stack(
                           alignment: Alignment.topRight,
                           children: [
                             GestureDetector(
                                onTap: (){
                                  setState(() {
                                    apiVm.selectedCategoryIndex = index;
                                  });
                                },
                               child: Container(
                                 margin: const EdgeInsets.only(right: 12),
                                 padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(8.0),
                                   border: Border.all(color: apiVm.selectedCategoryIndex==index?  Colors.red : Colors.grey),
                                 ),
                                 child: Text(apiVm.productModelList?[index].name??'' , style: TextStyle(
                                   color:  apiVm.selectedCategoryIndex==index?  Colors.black : Colors.grey,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               ),
                             ),
                              Positioned(
                                right: 7,
                                top: -4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                   border: Border.all(color:  apiVm.selectedCategoryIndex==index ? Colors.red: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(apiVm.productModelList?[index].subCategory?.length.toString()??'' , style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),),
                                ),
                              ),
                           ],
                         );
                       }),
                     ),
                   ),
                 ),
                  const SizedBox(height: 10,),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 20,),
                 SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: List.generate(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?.length??0, (index) {

                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                apiVm.selectedSubCategoryIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: apiVm.selectedSubCategoryIndex==index? Colors.red : Colors.grey),
                                        ),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[index].image??''),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //make widget showing counts of products
                                      Positioned(
                                        right: 0,
                                        top: -3,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: apiVm.selectedSubCategoryIndex==index? Colors.red : Colors.grey),
                                          ),
                                          child: Text(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[index].products?.length.toString()??'' , style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,

                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Text( apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[index].name??'' , style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),)
                                ],
                              ),
                            ),
                          );
                       }),
                     ),
                   ),
                 ),
                  const SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Row(
                     children: [
                       const Text('Products' , style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                         fontSize: 28
                       ),),
                       const SizedBox(width: 5,),
                       Padding(
                         padding: const EdgeInsets.only(top: 10.0),
                         child: Text('(${ apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].name??''})' , style: const TextStyle(
                           color: Colors.red,
                           fontWeight: FontWeight.bold,
                           fontSize: 12
                         ),),
                       ),
                       const Spacer(),
                        const Text('View All' , style: TextStyle(
                          color: Colors.red,

                          fontSize: 18,
                        ),),
                       const SizedBox(width: 5,),
                       const Icon(Icons.arrow_forward_ios , color: Colors.black,size: 12,),
                     ],
                   ),
                 ),
                  const SizedBox(height: 20,),
                 SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 16.0),
                     child: Row(
                       children: List.generate(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?.length??0, (index) {
                         //make a widget which will have image discount banner on left top corner ad fgavoute icon on right bottom corner
                          return Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: MediaQuery.of(context).size.width*0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12.0),
                                        child: Image.network(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].image??''),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(4.0)
                                        ),
                                        child: Text('${apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].discountPercentage.toString()}%' , style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: (){
                                          apiVm.addToFavorite(index);
                                        },
                                        child: IconButton(onPressed: (){
                                          apiVm.addToFavorite(index);
                                        }, icon: Icon(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].isFavorite==true? Icons.favorite : Icons.favorite_border , color: Colors.red,)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].name??'' , style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),),
                                const SizedBox(height: 10,),
                                //make Row with Text widget first and then price and then discount price
                                Row(
                                  children: [
                                    Text('\$${calculateDiscountPrice(double.parse(apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].price.toString()??'0.0') , apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].discountPercentage??0).toStringAsFixed(2)}' , style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough,
                                    ),),

                                    const SizedBox(width: 10,),
                                    Text('\$${apiVm.productModelList?[apiVm.selectedCategoryIndex].subCategory?[apiVm.selectedSubCategoryIndex].products?[index].price.toString()??''}' , style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                  ],
                                ),


                              ],
                            ),
                          );
                       }),
                     ),
                   ),
                 ),
                 const SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Image.asset('assets/images/banner.png' , scale: 3,),
                 ),
                  const SizedBox(height: 20,),
                 Image.asset('assets/images/bottom.png' , scale: 2,),
                 const SizedBox(height: 20,),


               ],
              ),
            ),
          ),
        );
      }
    );
  }
  Widget buildBottomSheet() {
    return Container(
      padding : const EdgeInsets.symmetric(horizontal: 6 , vertical: 20),
      color: Colors.red, // Background color of the bottom sheet
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          5,
              (index) => buildItem(index),
        ),
      ),
    );
  }

  Widget buildItem(int index) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = 0;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(// Highlight selected index
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          bottomImages[index],
          scale: 4,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}

