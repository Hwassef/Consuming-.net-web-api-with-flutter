using DAO;
using P1;
using P1.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GestionLivre.Model
{
    public class GererLivre : IGererLivre
    {
         IDAOLivre _DBLivre;
        ConnexionDB _db;
        public GererLivre(IDAOLivre dbLivre, ConnexionDB _dbContext)
        {
            _DBLivre = dbLivre;
            _db = _dbContext;
        }
        public double CalculerValuerBib()
        {
            List<Livre> livres = _DBLivre.GetLivres();

            double sum = 0;
            foreach (Livre livre in livres)
            {
                sum += livre.prix;
            }
            return sum;
        }

        public List<Livre> getLivres()
        {
            return  _DBLivre.GetLivres();

        }
        public bool deleteLivreById(int id)
        {
           Livre l = _db.Livres.Find(id);
            _db.Livres.Remove(l);
            _db.SaveChanges();
            return true;
        }

        public bool addLivre(Livre l)
        {
            _db.Livres.Add(l);
            _db.SaveChanges();
            return true;
        }
        public bool updateLivre(Livre newL)
        {
            Livre l = _db.Livres.Find(newL.id);
            l.titre = newL.titre;
            l.auteur = newL.auteur;
            l.nbExemplaire = newL.nbExemplaire;
            l.prix = newL.prix;
            _db.Livres.Update(l);
            _db.SaveChanges();
            return true;
        }
    }
}