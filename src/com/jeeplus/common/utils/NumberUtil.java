package com.jeeplus.common.utils;

import java.math.BigDecimal;

public class NumberUtil {
    /**
     * double保留i位小数点
     * @param num 要转化为数
     * @param i 保留位数
     * @return
     */
    public static String parseDouble(Double num,Integer i){
        if(StringUtils.isBlank(num+"")){
            return "";
        }
        Double value = new BigDecimal(num).setScale(i,BigDecimal.ROUND_HALF_UP).doubleValue();
        return value.toString();
    }
}
