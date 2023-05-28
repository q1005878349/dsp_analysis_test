import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONReader;
import com.github.psambit9791.jdsp.transform.ShortTimeFourier;
import com.github.psambit9791.jdsp.transform._Fourier;
import org.apache.commons.io.FileUtils;
import org.apache.commons.math3.complex.Complex;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;

public class Test {

    public static void main(String[] args) throws IOException {
        File file = new File("C:\\Users\\kay\\Desktop\\test_stft_transform\\src\\main\\java\\signal.json");

        DecimalFormat df = new DecimalFormat("#.00");

        String file1 = FileUtils.readFileToString(file);//前面两行是读取文件
        JSONObject jsonobject = JSON.parseObject(file1);
        JSONArray data = jsonobject.getJSONArray("data");
        List<Double> doubles = data.toJavaList(Double.class);
        double[] signal = new double[doubles.size()];
        for (int i=0; i<doubles.size(); i++) {
            signal[i] = doubles.get(i);
        }
        int frameLength = 256;
        int fourierLength = 512;
        int overlap = frameLength/4;
        ShortTimeFourier stft = new ShortTimeFourier(signal, frameLength, overlap, fourierLength);
        stft.transform();
        double[][] S = stft.spectrogram(false);
        double[] F = stft.getFrequencyAxis(true);
        double[] T = stft.getTimeAxis();
        for (int i = 0; i < F.length; i++) {
            F[i] = BigDecimal.valueOf(F[i]).multiply(BigDecimal.valueOf(1000))
                    .setScale(2, RoundingMode.CEILING)
                    .doubleValue();;
        }
        // 组装前端需要的数据, 应该是 [time, freq, magnitude]的形式
        Double[][] gen_data = new Double[S.length * T.length][3];
        for (int i = 0; i < S.length; i++) {
            double[] si = S[i];
            for (int j = 0; j < si.length; j++) {
                Double[] item = new Double[3];
                item[0] = Double.valueOf(j);
                item[1] = Double.valueOf(i);
                item[2] = Double.parseDouble(df.format(si[j]));
                gen_data[i * T.length + j] = item;
            }
        }

        JSONObject obj = new JSONObject();
        obj.put("x", T);
        obj.put("y", F);
        obj.put("data", gen_data);
        // 生成x轴的数据
        File output_file = new File("./ouput.json");
        if (!file.exists()) {
            output_file.createNewFile();
        }
        String obj_str = obj.toJSONString();
        FileUtils.writeStringToFile(output_file, obj_str);
    }

}
