/** @jsxImportSource @emotion/react */
import { css } from "@emotion/react";
import { getAllBaber } from "api/Baber/Baber.api";
import { setBaberItems } from "app/slice/babers.slice";
import { Baber } from "model/util.model";
import React, { useEffect, useState } from "react";
import Skeleton from "react-loading-skeleton";
import { useDispatch } from "react-redux";
import { useLocation } from "react-router";
// import { barberMock as baberData } from "./barberMock";
import { useEffectOnce, useToggle } from "react-use";
import "twin.macro";
import tw from "twin.macro";
import { groupData } from "utils/utils";
import { BarberItems } from "./BarberItems";

export const Barber = () => {
  const [barberData, setBarberData] = useState<Baber[][]>([]);
  const [idBarber, setIdBarber] = useState<string | null>(null);
  const [isProfilePage, toggleProfilePage] = useToggle(false);

  const dispatch = useDispatch();
  const location = useLocation();

  useEffectOnce(() => {
    const groupBaberItems = async () => {
      try {
        const baberData = await (await getAllBaber()).data;

        const data = groupData(baberData, 3);
        dispatch(setBaberItems(baberData));
        setBarberData(data);
      } catch (error) {
        console.log(error);
      }
    };
    groupBaberItems();
  });

  useEffect(() => {
    const urlParams = new URLSearchParams(location.search);
    const id = urlParams.get("id");
    if (id) {
      setIdBarber(id);
      toggleProfilePage(true);
    } else {
      setIdBarber(null);
      toggleProfilePage(false);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [location.search]);

  return (
    <div tw="w-full bg-gray-100">
      {isProfilePage ? (
        <div tw="mx-auto max-w-6xl">{idBarber}</div>
      ) : (
        <section tw="max-w-5xl mx-auto px-4 py-12">
          {barberData.map((groupData) => {
            return (
              <div tw="w-full mx-auto flex space-x-32">
                {groupData.map((item) => (
                  <BarberItems item={item} />
                ))}
              </div>
            );
          })}
        </section>
      )}
    </div>
  );
};

