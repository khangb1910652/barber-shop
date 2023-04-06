export interface Baber {
  id: string;
  avt: string;
  name: string;
  position: string;
  gender?: string;
  contact?: string;
  address?: string;
  birthDay?: string;
  isActive?: boolean;
  salary?: number;
  email?: string;
}

export interface Customer {
  id: string;
  name: string;
  date: Date;
  phone: string;
}

export interface Goods {
  id: string;
  name: string; // name group of service
  items: GoodItem[];
}

// export type Ser = Record<string, ServiceItem[]>

export interface GoodItem {
  id: string;
  idType: string;
  name: string;
  image: string;
  price: number;
}

export interface ProductDashBoard {
  name: string;
  orders: number;
  percent: number;
}

export interface TotalRank {
  booking: number;
  orders: number;
  services: number;
  balance: number;
}
