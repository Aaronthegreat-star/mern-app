import React from 'react'
import { Route, Routes } from 'react-router-dom'
import Home from './pages/Home'
import GetBook from './pages/GetBook'
import CreateBook from './pages/CreateBook'
import DeleteBook from './pages/DeleteBook'
import ModifyBook from './pages/ModifyBook'

const App = () => {
  return (
    <Routes>
      <Route path='/' element={<Home />} />
      <Route path='/books/create' element={<CreateBook />} />
      <Route path='/books/details/:id' element={<GetBook />} />
      <Route path='/books/edit/:id' element={<ModifyBook />} />
      <Route path='/books/delete/:id' element={<DeleteBook />} />
    </Routes>
  )
}

export default App
