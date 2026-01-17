import '../models/organic_item.dart';

class OrganicDatabase {
  static List<OrganicItem> items = [

    OrganicItem(
      title: "Tomato / टमाटर",
      problem: "Early Blight",
      description: "A fungal disease that attacks leaves and fruit.",
      symptoms: "Brown spots with concentric rings on lower leaves.",
      solution: "Proper spacing for airflow and mulching.",
      pesticide: "Sour Buttermilk spray (1:10 ratio) or Neem oil.",
      category: "Vegetable",
      imageUrl: "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400",
    ),
    OrganicItem(
      title: "Chilli / मिर्च",
      problem: "Leaf Curl Virus",
      description: "Virus transmitted by whiteflies.",
      symptoms: "Leaves curl upwards, stunted plant growth.",
      solution: "Remove infected plants immediately.",
      pesticide: "Garlic-Chilli extract spray or Yellow Sticky Traps.",
      category: "Vegetable",
      imageUrl: "https://www.shutterstock.com/image-photo/image-closeup-pile-green-chillies-260nw-2529426775.jpg",
    ),
    OrganicItem(
      title: "Potato / आलू",
      problem: "Late Blight",
      description: "Fast-spreading fungal infection.",
      symptoms: "Water-soaked dark patches on leaf tips.",
      solution: "Crop rotation and high-quality seed selection.",
      pesticide: "Ginger-Garlic-Onion extract (Dashparni Arka).",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0eqkPvKnP9hdTDq01i9tZi_u5EJvkzcBRg&s",
    ),
    OrganicItem(
      title: "Onion / प्याज",
      problem: "Purple Blotch",
      description: "Fungal disease reducing bulb size and quality.",
      symptoms: "Small purple lesions that expand into large streaks.",
      solution: "Improve field drainage and rotate with cereals.",
      pesticide: "Spray Neem Seed Kernel Extract (5%) periodically.",
      category: "Vegetable",
      imageUrl: "https://mybageecha.com/cdn/shop/products/Red-Onions.jpg?v=1571438537&width=1276",
    ),
    OrganicItem(
      title: "Okra / भिंडी",
      problem: "Yellow Vein Mosaic",
      description: "Viral disease making fruit inedible.",
      symptoms: "Veins turn bright yellow, plant turns pale.",
      solution: "Grow resistant varieties like Arka Anamika.",
      pesticide: "Garlic-Chilli spray to control whiteflies.",
      category: "Vegetable",
      imageUrl: "https://media.istockphoto.com/id/497752754/photo/okra-plant-close-up-organic-produce-food-farming.jpg?s=612x612&w=0&k=20&c=FaFHdu2AzGSc0IFQPZ6vu5nhjCDCdle8hg2HfrvUefw=",
    ),
    OrganicItem(
      title: "Brinjal / बैंगन",
      problem: "Fruit & Shoot Borer",
      description: "Larvae bore into tender shoots.",
      symptoms: "Wilting of shoots and holes in fruit.",
      solution: "Release Trichogramma cards (biological agent).",
      pesticide: "Spray Dashparni Arka or Neem Oil.",
      category: "Vegetable",
      imageUrl: "https://media.istockphoto.com/id/1175349177/photo/ripe-purple-eggplants.jpg?s=612x612&w=0&k=20&c=KeOqHB9tCrEMKxIKMj6I1Zn589n2zgWVGo5gtlCzBNI=",
    ),
    // --- FRUITS ---
    OrganicItem(
      title: "Mango / आम",
      problem: "Powdery Mildew",
      description: "Fungus affecting the flowering stage.",
      symptoms: "White powdery growth on flowers and fruits.",
      solution: "Pruning crowded branches for sunlight.",
      pesticide: "5% Ginger extract or Wood Ash dusting.",
      category: "Fruit",
      imageUrl: "https://images.unsplash.com/photo-1553279768-865429fa0078?w=400",
    ),
    OrganicItem(
      title: "Grapes / अंगूर",
      problem: "Downy Mildew",
      description: "Fungal disease in cloudy weather.",
      symptoms: "Yellow oily spots on upper leaf surface.",
      solution: "Improve vineyard sanitation.",
      pesticide: "Cow urine + Water (1:5) spray.",
      category: "Fruit",
      imageUrl: "https://www.foodrepublic.com/img/gallery/15-types-of-grapes-to-know-eat-and-drink/intro-1743188162.jpg",
    ),
    OrganicItem(
      title: "Banana / केला",
      problem: "Panama Wilt",
      description: "Soil-borne fungus attacking roots.",
      symptoms: "Yellowing of leaf margins and stem splitting.",
      solution: "Apply Trichoderma Viride to the soil.",
      pesticide: "Neem Cake application at the base.",
      category: "Fruit",
      imageUrl: "https://static.toiimg.com/thumb/msid-125267711,width-1280,height-720,resizemode-4/125267711.jpg",
    ),
    OrganicItem(
      title: "Lemon / नींबू",
      problem: "Citrus Canker",
      description: "Bacterial infection causing lesions on all plant parts.",
      symptoms: "Brown, raised, corky spots with yellow halos.",
      solution: "Sanitize pruning tools after every single use.",
      pesticide: "Spray Neem oil + Cow Urine (1:10) mixture.",
      category: "Fruit",
      imageUrl: "https://cdn.pixabay.com/photo/2017/02/05/12/31/lemons-2039830_1280.jpg",
    ),
    // --- GRAINS ---
    OrganicItem(
      title: "Rice / धान",
      problem: "Blast Disease",
      description: "Diamond-shaped lesions on leaves.",
      symptoms: "Neck rot and gray spots on leaf surface.",
      solution: "Treat seeds with Cow Urine before sowing.",
      pesticide: "Spray fermented curd and water mixture.",
      category: "Grain",
      imageUrl: "https://www.shutterstock.com/image-photo/bunch-paddy-rice-field-before-600nw-2219469869.jpg",
    ),
    OrganicItem(
      title: "Cotton / कपास",
      problem: "Pink Bollworm",
      description: "Larvae destroy cotton lint.",
      symptoms: "Bolls fail to open or rot inside.",
      solution: "Pheromone traps (10 per acre).",
      pesticide: "Spray Neem Seed Kernel Extract (5%).",
      category: "Cash Crop",
      imageUrl: "https://t4.ftcdn.net/jpg/06/84/31/79/360_F_684317966_Pn9qU1DEfW5zpwoj25znJ1i0VdaOM2Px.jpg",
    ),
    OrganicItem(
      title: "Mustard / सरसों",
      problem: "Aphids",
      description: "Small green insects sucking sap.",
      symptoms: "Sticky leaves and stunted pods.",
      solution: "Sow early to avoid peak aphid season.",
      pesticide: "Spray wood ash and soap water.",
      category: "Grain",
      imageUrl: "https://kandrafoods.com/wp-content/uploads/2022/12/mustard-seeds-min-scaled.jpeg",
    ),
    OrganicItem(
      title: "Wheat / गेहूं",
      problem: "Brown Rust",
      description: "Rust pustules appearing in winter months.",
      symptoms: "Orange-brown spots resembling iron rust.",
      solution: "Early sowing and balanced irrigation.",
      pesticide: "Spray Sour Whey or Neem seed kernel extract.",
      category: "Grain",
      imageUrl: "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=400",
    ),


  // ===================== 🌾 GRAINS =====================


  OrganicItem(
  title: "Maize / मक्का",
  problem: "Fall Armyworm",
  description: "Highly destructive caterpillar pest.",
  symptoms: "Ragged leaves and whorl damage.",
  solution: "Early monitoring.",
  pesticide: "Neem seed kernel extract.",
  category: "Grain",
  imageUrl: "https://cdn.britannica.com/36/167236-050-BF90337E/Ears-corn.jpg",
  ),

  // ===================== 🍎 FRUITS =====================



  OrganicItem(
  title: "Apple / सेब",
  problem: "Apple Scab",
  description: "Major fungal disease in hills.",
  symptoms: "Dark scab spots.",
  solution: "Pruning and sanitation.",
  pesticide: "Neem oil spray.",
  category: "Fruit",
  imageUrl: "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400",
  ),

  // ===================== 🌸 FLOWERS =====================

  OrganicItem(
  title: "Rose / गुलाब",
  problem: "Black Spot",
  description: "Common fungal disease.",
  symptoms: "Black circular leaf spots.",
  solution: "Remove infected leaves.",
  pesticide: "Neem oil spray.",
  category: "Flower",
  imageUrl: "https://www.thespruce.com/thmb/0qu_LK3udbFtJyzV8DMnUc_jqwI=/5594x0/filters:no_upscale():max_bytes(150000):strip_icc()/types-of-roses-4069722-hero-17f5468ab53b4622b27e3d96534105db.jpg",
  ),

  OrganicItem(
  title: "Marigold / गेंदा",
  problem: "Damping Off",
  description: "Seedling fungal disease.",
  symptoms: "Seedlings collapse.",
  solution: "Well-drained soil.",
  pesticide: "Trichoderma soil treatment.",
  category: "Flower",
  imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc9gjVtLCkfVbCpLBOtv4HbRTIJo6R9nwv8w&s",
  ),

  // ===================== 🌱 CASH CROPS =====================


  OrganicItem(
  title: "Sugarcane / गन्ना",
  problem: "Red Rot",
  description: "Fungal stalk disease.",
  symptoms: "Red discoloration inside cane.",
  solution: "Use resistant varieties.",
  pesticide: "Trichoderma soil application.",
  category: "Cash Crop",
  imageUrl: "https://cdn.britannica.com/67/125067-050-F318A0E6/Sugarcane.jpg",
  ),
// ............................................................
    OrganicItem(
      title: "Turmeric / हल्दी",
      problem: "Rhizome Rot",
      description: "Fungal disease in waterlogged soil.",
      symptoms: "Yellowing leaves and soft rhizomes.",
      solution: "Improve drainage.",
      pesticide: "Trichoderma soil treatment",
      category: "Spice",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROJXMi4NBlGGCxi-Hsztw0wi0y-kU1STFXMQ&s" ),

    OrganicItem(
      title: "Barley / जौ",
      problem: "Stripe Rust",
      description: "Rust disease in cold climate.",
      symptoms: "Yellow stripes on leaves.",
      solution: "Resistant varieties.",
      pesticide: "Sulfur-based organic fungicide.",
      category: "Grain",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkfTw8JxPxUkHhuMZoJMFPy3QR_hLMgBFweg&s",
    ),

    OrganicItem(
      title: "Sorghum / ज्वार",
      problem: "Grain Mold",
      description: "Fungal infection during humid flowering stage.",
      symptoms: "Discolored grains with black or pink coating.",
      solution: "Timely harvesting and proper drying.",
      pesticide: "Spray neem oil 3%",
      category: "Grain",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwn3msRSGu38_8cJVaco_rv5nfLeFJSEkPiA&s"),

    OrganicItem(
      title: "Pearl Millet / बाजरा",
      problem: "Downy Mildew",
      description: "Common fungal disease in warm and humid areas.",
      symptoms: "Yellow streaks and white fungal growth.",
      solution: "Seed treatment and crop rotation.",
      pesticide: "Trichoderma-based bio fungicide",
      category: "Grain",
      imageUrl: "https://www.greendna.in/cdn/shop/products/perl5_500x.jpg?v=1750257706" ),

    OrganicItem(
      title: "Spinach / पालक",
      problem: "Leaf Miner",
      description: "Larvae feeding inside leaf tissue.",
      symptoms: "White zig-zag lines on leaves.",
      solution: "Remove affected leaves early.",
      pesticide: "Neem oil spray",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRthaBBQl70HmoLq5hRw6mVlCQc3FTAOoxvZg&s" ),

    OrganicItem(
      title: "Fenugreek / मेथी",
      problem: "Powdery Mildew",
      description: "Fungal disease in dry climate.",
      symptoms: "White powdery coating on leaves.",
      solution: "Improve air circulation.",
      pesticide: "Sulfur dust spray",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDy-qz_cdsI2G0gQFicxK5QRGX6Ayg88cyDg&s",
    ),

    OrganicItem(
      title: "Carrot / गाजर",
      problem: "Root Knot Nematode",
      description: "Soil-borne pest damaging roots.",
      symptoms: "Swollen knots on roots.",
      solution: "Soil solarization.",
      pesticide: "Neem cake application",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLex9eYC6TWsKCVJxe_Z1G0I8UT5S9Mfhblw&s"),

    OrganicItem(
      title: "Sweet Potato / शकरकंद",
      problem: "Weevil Attack",
      description: "Serious pest damaging tubers.",
      symptoms: "Holes and tunnels in roots.",
      solution: "Early harvesting.",
      pesticide: "Neem oil soil drench",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLRDu2GkVpE6A5rsv8h7JrnVoxRF2Ccv2eIQ&s",
    ),

    OrganicItem(
      title: "Chickpea / चना",
      problem: "Wilt Disease",
      description: "Soil-borne fungal disease.",
      symptoms: "Sudden wilting of plants.",
      solution: "Use resistant varieties.",
      pesticide: "Trichoderma seed treatment",
      category: "Pulse",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-g9VARgSRFH7onAWZX4fkaC4f8Fls24M3fA&s",
    ),

    OrganicItem(
      title: "Green Gram / मूंग",
      problem: "Yellow Mosaic Virus",
      description: "Virus transmitted by whiteflies.",
      symptoms: "Yellow patches on leaves.",
      solution: "Early sowing.",
      pesticide: "Neem oil spray",
      category: "Pulse",
      imageUrl: "https://www.apnikheti.com/upload/crops/9001idea99green_gram_crop_banner.jpg",
    ),

    OrganicItem(
      title: "Guava / अमरूद",
      problem: "Fruit Fly Infestation",
      description: "Egg-laying flies damage ripening fruits.",
      symptoms: "Soft rotten patches with maggots inside.",
      solution: "Collect and destroy fallen fruits.",
      pesticide: "Neem oil trap spray",
      category: "Fruit",
      imageUrl: "https://m.media-amazon.com/images/I/71U722K7GdL._AC_UF1000,1000_QL80_.jpg"),

    OrganicItem(
      title: "Pomegranate / अनार",
      problem: "Fruit Cracking",
      description: "Physiological disorder due to irregular watering.",
      symptoms: "Cracks on fruit surface.",
      solution: "Maintain uniform irrigation.",
      pesticide: "Seaweed extract spray",
      category: "Fruit",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXGkSyPlyv7asOGrsAfFiJaUclS-3OhZT3sg&s"),

    OrganicItem(
      title: "Groundnut / मूंगफली",
      problem: "Tikka Leaf Spot",
      description: "Fungal disease during monsoon.",
      symptoms: "Brown circular spots on leaves.",
      solution: "Crop rotation.",
      pesticide: "Trichoderma foliar spray",
      category: "Oilseed",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbKd9N7ZtSHxWje5mO9jxPnpN0ZwGCfzF8FQ&s"),

    OrganicItem(
      title: "Cabbage / पत्ता गोभी",
      problem: "Diamondback Moth",
      description: "Larvae feed on leaf tissue.",
      symptoms: "Small holes and skeletonized leaves.",
      solution: "Use pheromone traps.",
      pesticide: "Neem seed kernel extract",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXZrMqnp6XkG4n-xPGUjMeTqHux1TlYfb4-w&s"),

    OrganicItem(
      title: "Gerbera",
      problem: "Root Rot",
      description: "Soil-borne fungal infection.",
      symptoms: "Yellowing and wilting plants.",
      solution: "Improve soil drainage.",
      pesticide: "Trichoderma soil drench",
      category: "Flower",
      imageUrl:"https://www.planetnatural.com/wp-content/uploads/2023/10/Gerbera-Daisies.jpg" ),

    OrganicItem(
      title: "Coffee",
      problem: "Coffee Rust",
      description: "Fungal disease affecting leaves.",
      symptoms: "Orange powdery spots under leaves.",
      solution: "Shade regulation.",
      pesticide: "Bordeaux mixture (organic)",
      category: "Plantation",
      imageUrl: "https://weaverscoffee.com/cdn/shop/articles/Coffee_beans_and_red_ripe_coffee_cherries_on_coffee_tree_1000x.jpg?v=1695928346",
    ),

    OrganicItem(
      title: "Petunia",
      problem: "Leaf Spot",
      description: "Fungal leaf disease.",
      symptoms: "Brown spots on foliage.",
      solution: "Remove infected leaves.",
      pesticide: "Neem oil spray",
      category: "Flower",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHLE_5LjTjP23qMsffqsCj2eqBV_4IkxnsEw&s"),

    OrganicItem(
      title: "Papaya / पपीता",
      problem: "Papaya Ring Spot Virus",
      description: "Virus spread by aphids.",
      symptoms: "Ring-shaped marks on fruits and leaves.",
      solution: "Remove infected plants early.",
      pesticide: "Neem oil spray",
      category: "Fruit",
      imageUrl: "https://images.jansatta.com/2025/12/Real-And-Fake-Papaya.jpg",
    ),

    OrganicItem(
      title: "Litchi / लीची",
      problem: "Fruit Borer",
      description: "Larvae damage developing fruits.",
      symptoms: "Holes with frass on fruits.",
      solution: "Timely harvesting.",
      pesticide: "Neem seed kernel extract",
      category: "Fruit",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRompwPCMSHQOvyJQY3u_1vcyp5JBBuaSD5Lw&s"),

    OrganicItem(
      title: "Cauliflower / फूल गोभी",
      problem: "Black Rot",
      description: "Bacterial disease in warm and humid climate.",
      symptoms: "V-shaped yellow lesions on leaves.",
      solution: "Use disease-free seeds.",
      pesticide: "Copper-based bio spray",
      category: "Vegetable",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs2nkgtnOdBIITduwaCvruhOJ3NWgg9WSzhg&s"),

    OrganicItem(
      title: "Bottle Gourd / लौकी",
      problem: "Powdery Mildew",
      description: "Fungal disease in dry weather.",
      symptoms: "White powdery growth on leaves.",
      solution: "Avoid overcrowding.",
      pesticide: "Sulfur spray",
      category: "Vegetable",
      imageUrl: "https://i0.wp.com/blog.organicbazar.net/wp-content/uploads/2022/02/shutterstock_1809569164.jpg?resize=800%2C535&ssl=1",
    ),

    OrganicItem(
      title: "Cowpea / लोबिया",
      problem: "Pod Borer",
      description: "Larvae feed on flowers and pods.",
      symptoms: "Holes in pods.",
      solution: "Timely sowing.",
      pesticide: "Neem oil 3%",
      category: "Pulse",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShOH_DE1nb4iPURaOOS5Iu4Sngf-Iu5G5pIw&s",
    ),

    OrganicItem(
      title: "Field Pea / मटर",
      problem: "Powdery Mildew",
      description: "Fungal disease in cool climate.",
      symptoms: "White powder on leaves.",
      solution: "Balanced fertilization.",
      pesticide: "Sulfur dust",
      category: "Pulse",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5nmMSn92_daWhvxOE0SmFmoOUDQiE61DGMQ&s",
    ),

    OrganicItem(
      title: "Sesame / तिल",
      problem: "Phyllody Disease",
      description: "Mycoplasma disease spread by leafhoppers.",
      symptoms: "Flowers turn leafy.",
      solution: "Remove infected plants.",
      pesticide: "Neem oil spray",
      category: "Oilseed",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnXvwoqTG4mhU_xzvUPogIRWQz-gjLLJz25g&s",
    ),

    OrganicItem(
      title: "Linseed / अलसी",
      problem: "Rust Disease",
      description: "Fungal infection on foliage.",
      symptoms: "Orange pustules on leaves.",
      solution: "Crop rotation.",
      pesticide: "Sulfur spray",
      category: "Oilseed",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR2kaz05saPMwUZ8lsxGa1p3OU40sRsJvSqg&s",
    ),

    OrganicItem(
      title: "Tuberose / रजनीगंधा",
      problem: "Leaf Blight",
      description: "Fungal disease during rainy season.",
      symptoms: "Brown leaf lesions.",
      solution: "Avoid water stagnation.",
      pesticide: "Neem oil spray",
      category: "Flower",
      imageUrl: "https://blog.organicbazar.net/wp-content/uploads/2022/04/tuberose-min-1.jpg"),

    OrganicItem(
      title: "Lotus / कमल",
      problem: "Leaf Spot",
      description: "Fungal infection in stagnant water.",
      symptoms: "Dark spots on leaves.",
      solution: "Remove infected leaves.",
      pesticide: "Trichoderma water treatment",
      category: "Flower",
      imageUrl: "https://www.1mg.com/hi/patanjali/wp-content/uploads/2019/01/Benefits-of-Lotus.png",
    ),

    OrganicItem(
      title: "Aloe Vera / घृतकुमारी",
      problem: "Soft Rot",
      description: "Bacterial infection due to excess moisture.",
      symptoms: "Soft, foul-smelling plant base.",
      solution: "Improve drainage.",
      pesticide: "Trichoderma soil drench",
      category: "Medicinal",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDcmycm6PdDSw0_us7TB-Pi6B6i54oS6tP9g&s",
    ),

    OrganicItem(
      title: "Tulsi / तुलसी",
      problem: "Leaf Spot",
      description: "Fungal leaf disease.",
      symptoms: "Brown spots on leaves.",
      solution: "Proper spacing.",
      pesticide: "Neem oil spray",
      category: "Medicinal",
      imageUrl: "https://images.jansatta.com/2025/11/How-to-store-fresh-basil-leaves-in-the-fridge-How-to-store-fresh-cut-basil-leaves-How-long-to-keep-basil-fresh-and-green-How-to-store-fresh-basil-leaves-in-the-freezer.jpg",
    ),

    OrganicItem(
      title: "Peach / आड़ू",
      problem: "Leaf Curl",
      description: "Fungal disease common in cool, wet springs.",
      symptoms: "Twisted, thickened reddish leaves.",
      solution: "Prune and destroy infected shoots.",
      pesticide: "Lime sulfur spray",
      category: "Fruit",
      imageUrl: "https://image.myupchar.com/674/webp/aadu-ke-fayde-aur-nuksan-in-hindi-1.webp",
    ),

    OrganicItem(
      title: "Plum / आलूबुखारा",
      problem: "Brown Rot",
      description: "Fungal infection during flowering and fruiting.",
      symptoms: "Brown rotting fruits with mold.",
      solution: "Remove mummified fruits.",
      pesticide: "Bordeaux mixture",
      category: "Fruit",
      imageUrl: "https://m.media-amazon.com/images/I/91FS9nT6g2L._AC_UF1000,1000_QL80_.jpg",
    ),

    OrganicItem(
      title: "Cucumber / खीरा",
      problem: "Angular Leaf Spot",
      description: "Bacterial disease in humid weather.",
      symptoms: "Water-soaked angular spots on leaves.",
      solution: "Avoid overhead irrigation.",
      pesticide: "Copper-based bio fungicide",
      category: "Vegetable",
      imageUrl: "https://akm-img-a-in.tosshub.com/aajtak/images/story/202404/661603abd6db0-kheere-ki-kheti-101242595-16x9.jpg?size=948:533",
    ),

    OrganicItem(
      title: "Pumpkin / कद्दू",
      problem: "Vine Borer",
      description: "Larvae bore into stems causing wilting.",
      symptoms: "Sudden wilting of vines.",
      solution: "Remove affected vines early.",
      pesticide: "Neem oil stem spray",
      category: "Vegetable",
      imageUrl:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXRNssIpFhdvOzgBvi1bkUTgdPYlW-Quxc9Q&s" ),

    OrganicItem(
      title: "Black Pepper / काली मिर्च",
      problem: "Quick Wilt",
      description: "Soil-borne fungal disease.",
      symptoms: "Sudden wilting and leaf drop.",
      solution: "Improve drainage.",
      pesticide: "Trichoderma soil application",
      category: "Plantation",
    imageUrl: "https://sc02.alicdn.com/kf/H6b02178378104bb88c196055c9d9f7dfG.png"),

    OrganicItem(
      title: "Cardamom / इलायची",
      problem: "Capsule Rot",
      description: "Fungal disease in high rainfall areas.",
      symptoms: "Brown lesions on capsules.",
      solution: "Shade regulation.",
      pesticide: "Neem oil spray",
      category: "Plantation",
      imageUrl: "https://m.media-amazon.com/images/I/61BTjMwbR4L._AC_UF894,1000_QL80_.jpg",
    ),

    OrganicItem(
      title: "Berseem / बरसीम",
      problem: "Stem Rot",
      description: "Fungal infection in waterlogged fields.",
      symptoms: "Soft rotting at stem base.",
      solution: "Ensure proper drainage.",
      pesticide: "Trichoderma seed treatment",
      category: "Fodder",
      imageUrl: "https://www.feedipedia.org/sites/default/files/images/Berseem-Egypt.jpg",
    ),

    OrganicItem(
      title: "Napier Grass",
      problem: "Leaf Blight",
      description: "Fungal disease reducing fodder quality.",
      symptoms: "Brown elongated lesions on leaves.",
      solution: "Timely cutting.",
      pesticide: "Neem oil spray",
      category: "Fodder",
      imageUrl: "https://rukminim2.flixcart.com/image/480/640/k2m6ufk0/plant-seed/z/p/g/24000-super-napier-grass-seed-high-yield-100-gm-24000-seeds-mgbn-original-imafhwcqt2zs5kmc.jpeg?q=90",
    ),

    OrganicItem(
      title: "Hibiscus / गुड़हल",
      problem: "Mealy Bug",
      description: "Sap-sucking insect infestation.",
      symptoms: "White cottony masses on stems.",
      solution: "Prune heavily infested parts.",
      pesticide: "Neem oil + soap solution",
      category: "Ornamental",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSuPkDmth8e61u3IOh84z1hnXBweZnaucXyw&s",
    ),

    OrganicItem(
      title: "Bougainvillea",
      problem: "Leaf Curl",
      description: "Insect and nutrient stress related issue.",
      symptoms: "Curled, distorted leaves.",
      solution: "Balanced nutrition.",
      pesticide: "Neem oil spray",
      category: "Ornamental",
      imageUrl: "https://gardenerspath.com/wp-content/uploads/2022/09/How-to-Grow-Bougainvillea-FB.jpg",
    ),

    OrganicItem(
      title: "Ashwagandha",
      problem: "Leaf Spot",
      description: "Fungal disease under humid conditions.",
      symptoms: "Brown spots on leaves.",
      solution: "Proper spacing.",
      pesticide: "Neem oil spray",
      category: "Medicinal",
      imageUrl: "https://www.indovedic.com/wp-content/uploads/2022/07/ashwa.png",
    ),

    OrganicItem(
      title: "Lemongrass",
      problem: "Red Leaf Spot",
      description: "Fungal disease affecting oil yield.",
      symptoms: "Reddish brown spots on leaves.",
      solution: "Remove affected clumps.",
      pesticide: "Trichoderma spray",
      category: "Medicinal",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR016A33A-6zv95Sko7og11ORUuYrdhIX_GVg&s",
    ),


    // TIP: COPY AND PASTE THESE ITEMS TO QUICKLY REACH 100+ ENTRIES FOR YOUR DEMO
  ];
}