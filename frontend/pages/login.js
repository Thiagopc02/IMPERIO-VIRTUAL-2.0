import { useState, useEffect } from 'react';
import axios from 'axios';
import { useRouter } from 'next/router';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

export default function Login() {
  const router = useRouter();
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [isRegistering, setIsRegistering] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (isRegistering && password !== confirmPassword) {
      setError('As senhas não coincidem.');
      return;
    }

    try {
      if (isRegistering) {
        await axios.post('http://localhost:5000/api/auth/register', { name, email, phone, password });
        toast.success('Cadastro realizado com sucesso! Agora você pode fazer login.');
        setIsRegistering(false);
      } else {
        const response = await axios.post('http://localhost:5000/api/auth/login', { email, password });
        
        if (typeof window !== 'undefined') {
          localStorage.setItem('token', response.data.token);
          localStorage.setItem('user', JSON.stringify(response.data.user));

          // Armazene a URL de retorno
          const redirectTo = localStorage.getItem('redirectAfterLogin') || '/';
          localStorage.removeItem('redirectAfterLogin');
          router.push(redirectTo); // Redireciona para a página armazenada
        }
      }
    } catch (error) {
      console.error('Erro ao processar a solicitação:', error);
      setError('Erro ao processar a solicitação. Tente novamente.');
    }
  };

  useEffect(() => {
    // Limpar URL de redirecionamento ao desmontar o componente, se necessário
    return () => {
      localStorage.removeItem('redirectAfterLogin');
    };
  }, []);

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white p-8 rounded shadow-md w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center">{isRegistering ? 'Cadastrar' : 'Login'}</h2>
        {error && <p className="text-red-500 mb-4 text-center">{error}</p>}
        <form onSubmit={handleSubmit}>
          {isRegistering && (
            <>
              <div className="mb-4">
                <label htmlFor="name" className="block text-gray-700">Nome:</label>
                <input
                  type="text"
                  id="name"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded mt-1 text-black"
                  required
                />
              </div>
              <div className="mb-4">
                <label htmlFor="phone" className="block text-gray-700">Número de Celular:</label>
                <input
                  type="tel"
                  id="phone"
                  value={phone}
                  onChange={(e) => setPhone(e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded mt-1 text-black"
                  required
                />
              </div>
            </>
          )}
          <div className="mb-4">
            <label htmlFor="email" className="block text-gray-700">E-mail:</label>
            <input
              type="email"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full p-2 border border-gray-300 rounded mt-1 text-black"
              required
            />
          </div>
          <div className="mb-4">
            <label htmlFor="password" className="block text-gray-700">Senha:</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full p-2 border border-gray-300 rounded mt-1 text-black"
              required
            />
          </div>
          {isRegistering && (
            <div className="mb-6">
              <label htmlFor="confirmPassword" className="block text-gray-700">Confirme a Senha:</label>
              <input
                type="password"
                id="confirmPassword"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                className="w-full p-2 border border-gray-300 rounded mt-1 text-black"
                required
              />
            </div>
          )}
          <button type="submit" className="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition-colors">
            {isRegistering ? 'Cadastrar' : 'Entrar'}
          </button>
        </form>
        <div className="mt-4 text-center">
          <button onClick={() => setIsRegistering(!isRegistering)} className="text-blue-600 hover:underline">
            {isRegistering ? 'Já tem uma conta? Faça login' : 'Não tem uma conta? Cadastre-se'}
          </button>
        </div>
        <ToastContainer />
      </div>
    </div>
  );
}
