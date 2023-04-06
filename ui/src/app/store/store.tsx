import { createStore } from "@reduxjs/toolkit";
import { rootReducer } from "app/reducers/reducers";
import React from "react";
import { Provider } from "react-redux";
import { applyMiddleware } from "redux";
import thunk from "redux-thunk";
import { composeWithDevTools } from "redux-devtools-extension";

export const Store: React.FC = ({ children }) => {
  const store = createStore(
    rootReducer,
    // process.env.REACT_APP_STAGE === "dev" ?
    composeWithDevTools(applyMiddleware(thunk))
    // : applyMiddleware(thunk)
  );
  return <Provider store={store}>{children}</Provider>;
};
