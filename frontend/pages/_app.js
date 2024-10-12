import '../styles/globals.css';
import Head from 'next/head';  // Importando o Head do Next.js
import Header from '../components/Header'; // Caminho ajustado
import Footer from '../components/Footer'; // Caminho ajustado
import { CartProvider } from '../components/context/CartContext'; // Caminho ajustado
import '../components/StarRating.css'; // Caminho ajustado

function MyApp({ Component, pageProps }) {
  return (
    <CartProvider>
      <Head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="Império Bebidas e Tabacos" />
        <meta name="keywords" content="bebidas, tabacos, ecommerce" />
        <meta name="author" content="Império Bebidas e Tabacos" />
        <link rel="icon" href="/favicon.icon" />
        <title>Império Bebidas e Tabacos</title> {/* Adicione o título do site aqui */}
      </Head>
      <div>
        <Header />
        <main>
          <Component {...pageProps} />
        </main>
        <Footer />
      </div>
    </CartProvider>
  );
}

export default MyApp;