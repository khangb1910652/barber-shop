import express from "express";
import { connection } from "../../database/mysql";

const router = express.Router();

export const get_baber_by_id = () => {
  return router.post(
    "/",
    async (req: express.Request, res: express.Response) => {
      try {
        
        const { idbaber } = req.body;
        const sql = "SELECT * FROM baber where idbaber = ?";
        connection.query(sql, [idbaber], function (err, results) {
          if (err) throw err;
          res.send(results);
        });

        // sql
        // const baber = {};
        // res.json(baber);
      } catch (error) {
        res.json({
          status: 400,
          body: error,
        });
      }
    }
  );
};
