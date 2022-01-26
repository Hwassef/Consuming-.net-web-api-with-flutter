using GestionLivre.Model;
using Microsoft.AspNetCore.Mvc;
using P1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GestionLivre.Controllers
{
    [ApiController]
    [Route("test")]
    public class LivreController : Controller
    {
        private IGererLivre _objGererLivre;
        public LivreController(IGererLivre gererLivre)
        {
            _objGererLivre = gererLivre;
        }
        [HttpGet]
        public JsonResult getLivres()
        {
            return Json(_objGererLivre.getLivres());
        }
        [HttpDelete("{id}")]
            public bool deleteLivreById([FromRoute]int id)
        {
               return  _objGererLivre.deleteLivreById(id);
        }
        [HttpPut]
        public bool addLivre(Livre l)
        {
            return _objGererLivre.addLivre(l);
        }
        [HttpPut("{id}")]
        public bool updateLivre(Livre l)
        {
            return _objGererLivre.updateLivre(l);
        }
    }
}
