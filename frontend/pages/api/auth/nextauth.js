import NextAuth from 'next-auth';
import GoogleProvider from 'next-auth/providers/google';

export default NextAuth({
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
  ],
  // Use um adaptador que se conecte ao banco de dados via uma URL
  // Ou você pode implementar uma estratégia de autenticação diferente
  // e se comunicar com o backend via uma API REST personalizada
});