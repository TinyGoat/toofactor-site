$CUSTOMER_REDIS = Redis::Namespace.new(:customer, :redis => $REDIS)