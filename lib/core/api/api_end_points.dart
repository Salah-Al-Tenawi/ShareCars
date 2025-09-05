
class ApiEndPoint {
   static const baserUrl = "http://192.168.1.6:8000/api";
  // static const baserUrl = "http://192.168.118.103:8000/api/";

  static const mapsOpenRouteServices =
      "https://api.openrouteservice.org/v2/directions/driving-car/geojson";
  static const mapsGraphHopper = "https://graphhopper.com/api/1/route";

  // auth
  static const login = "$baserUrl/login";
  static const singin = "$baserUrl/signup";
  static const logout = "$baserUrl/logout";
  static const forgetPassword = "$baserUrl/forgot-password";
  static const resetPassword = "$baserUrl/reset-password";
  static const profile = "$baserUrl/profile";

  static const verifypassenger = "$profile/verify/passenger";
  static const verifydriver = "$profile/verify/driver";
  static const rateUser = "$profile/rate";

//  trips endpoint
  static const rides = "$baserUrl/rides";
  //chat
   static const chat = "$baserUrl/chat";
   static const startconversation = "$chat/conversations";
    static const getallconversations = "$chat/conversations";
 static const message = "$chat/conversations";
 static const deletmessage = "$chat/messages";
}

class ApiKey {
  // Authorization
  static const authorization = "Authorization";
  static const data = "data";
  static const success = "success";
  static const message = "message"; 
  
  static const error = "error";
  static const token = "access_token";
  static const contentType = "Content-Type";


  // User Info
  static const userId = "user_id";
  static const id = "id";
  static const user = "user";
  static const fullName = "full_name";
  static const firstName = "first_name";
  static const lastName = "last_name";
  static const address = "address";
  static const email = "email";
  static const password = "password";
  static const passwordConfirm = "password_confirmation";
  static const gender = "gender";
  static const profilePhoto = "profile_photo";
  static const description = "description";
  static const verificationStatus = "verification_status";
  static const numberOfRides = "number_of_rides";
  static const drivingLicensePic = "driving_license_pic";

  static const rating = "rating";
  static const totalRatings = "total_ratings";
  static const averageRating = "average_rating";

  // Car Info
  static const typeOfCar = "type_of_car";
  static const colorOfCar = "color_of_car";
  static const numberOfSeats = "number_of_seats";
  static const carPic = "car_pic";
  static const radio = "radio";
  static const smoking = "smoking";

  // Documents
  static const documents = "documents";
  static const faceIdPic = "face_id_pic";
  static const backIdPic = "back_id_pic";
  static const licensePic = "driving_license_pic";
  static const mechanicCardPic = "mechanic_card_pic";

  // Comments

  static const name = "name";
  static const comments = "comments";
  static const comment = "comment";
  static const commenter = "commenter";
  static const createdAt = "created_at";

  // rides
  static const pickupAddress = "pickup_address";
  static const destinationAddress = "destination_address";
  static const departureTime = "departure_time";
  static const availableSeats = "available_seats";
  static const seats = "seats";
  static const pricePerSeat = "price_per_seat";

  // maps
  static const coordinates = "coordinates";
  static const alternativeRoutes = "alternative_routes";
  static const targetCount = "target_count";
  static const shareFactor = "share_factor";
  static const features = "features";
  //chath
  static const  conversationid ="conversation_id";
   static const  type ="type";
    static const  title ="title";
     static const  otherparticipant ="other_participant";
      static const  lastmessage ="last_message";
       static const  updatedat ="updated_at";
        static const  content ="content";
         static const  metadata ="metadata";
          static const  isedited ="is_edited";
        static const  avatar ="avatar";
          static const  caption ="caption";
            static const  image ="image";
         static const  createdat ="created_at";
            static const  sender ="sender";
             static const  sendername ="sender_name";
       

}
