import React from 'react';
import { createRoot } from 'react-dom';
import App from './App';
import './styles.css';

const root = createRoot(document.getElementById('app'));
root.render(<App />);