using P1;
using P1.Interface;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class DAOImpLivre : IDAOLivre
    {
        private readonly ConnexionDB _db;
        public DAOImpLivre(ConnexionDB db)
        {
            _db = db;
        }
        public List<Livre> GetLivres()
        {
            return _db.Livres.ToList();
        }
    }
}
