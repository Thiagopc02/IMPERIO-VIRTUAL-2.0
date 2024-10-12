export default function Footer() {
  return (
    <footer className="bg-gray-800 text-white p-4 mt-8">
      <div className="flex justify-between">
        <p>&copy; Desde 2020 Império Virtual. Todos os direitos reservados.</p>
        <div className="space-x-4">
          {/* Link do WhatsApp com mensagem de ajuda */}
          <a
            href="https://wa.me/62996916206?text=Olá,%20preciso%20de%20ajuda%20com%20o%20meu%20pedido."
            target="_blank"
            rel="noopener noreferrer"
            className="hover:underline"
          >
            Whatsapp
          </a>
          {/* Link do Instagram */}
          <a
            href="https://www.instagram.com/imperiodistribuidora3015?igsh=eTZ0MXJ2enBtem9k&utm_source=qr"
            target="_blank"
            rel="noopener noreferrer"
            className="hover:underline"
          >
            Instagram
          </a>
          {/* Link do Facebook (se precisar, pode ajustar a URL) */}
          <a
            href="#"
            className="hover:underline"
          >
            Facebook
          </a>
        </div>
      </div>
    </footer>
  );
}