import { Html, Head, Main, NextScript } from 'next/document';

export default function Document() {
  return (
    <Html lang="pt-BR">
      <Head>
        {/* Adicione o favicon */}
        <link rel="icon" href="/favicon.icon.png" />
        
        {/* Meta tags recomendadas */}
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="Império Bebidas e Tabacos" />
        <meta name="keywords" content="bebidas, tabacos, ecommerce" />
        <meta name="author" content="Império Bebidas e Tabacos" />
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
