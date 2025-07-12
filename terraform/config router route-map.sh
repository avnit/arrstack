config router route-map

   edit nexthop1

      config rule

            edit 1

               set set-ip-nexthop 192.168.1

               unset set-ip-prefsrc

            next

      end

   next

   edit nexthop2

      config rule

            edit 1

               set set-ip-nexthop 10.15.0.253

               unset set-ip-prefsrc

            next

      end

   next

end
 
config router bgp

   set as 65200

   set router-id 10.15.0.2

   config neighbor

      edit 10.15.0.252
            set capability-default-originate enable
            set ebgp-enforce-multihop enable
            set soft-reconfiguration enable
            set remote-as 65512
            set route-map-in nexthop1

      next

      edit 10.15.0.253

            set capability-default-originate enable

            set ebgp-enforce-multihop enable

            set soft-reconfiguration enable

            set remote-as 65100

            set route-map-in nexthop2

      next

   end

end
 