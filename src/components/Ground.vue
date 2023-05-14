<template>
  <div class="ground">
    <Header/>
    <Search/>
    <Footer/>
</div>
</template>

<script>  
import Header from "./Header.vue";
import Footer from "./Footer.vue";
import Search from "./Search.vue";

export default{
  components:{Header, Footer, Search}

}
</script>