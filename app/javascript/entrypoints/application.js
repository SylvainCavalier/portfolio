import "../entrypoints/application.css";

import { createApp } from 'vue';
import App from "../components/App.vue";

createApp(App).mount('#app');

import "@hotwired/turbo-rails";