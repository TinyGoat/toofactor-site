$CUSTOMER_REDIS = Redis::Namespace.new(:customer, :redis => $REDIS)
$CUSTOMER_DEV_REDIS = Redis::Namespace.new(:dev, :redis => $REDIS)