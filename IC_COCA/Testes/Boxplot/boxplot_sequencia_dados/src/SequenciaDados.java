import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class SequenciaDados {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		String strDir = "/home/wes/Dropbox/Projects/IA/Programs/General Code/Testes/Boxplot/second";// args[1];
		File pasta = new File(strDir);
		File[] arquivos = pasta.listFiles();

		File output = new File(pasta.getAbsolutePath() + "/saida");
		if (!output.exists()) {//cria se nao existe o dir
			output.mkdir();
		}

		for (File f : arquivos) {

			if (f.getName().endsWith("_data_boxplot.out")) {
				System.out.println("Gerar sequencia correta para o Box Plot");

				ArrayList<String> listHj;
				ArrayList<String> listRvns;
				ArrayList<String> listUrvns;
				ArrayList<String> listBvns;
				ArrayList<String> listUbvns;

				HashMap<String, ArrayList<String>> dados = new HashMap<String, ArrayList<String>>();

				// faz a leitura do arquivo
				FileReader fr;
				try {
					fr = new FileReader(f);

					BufferedReader br = new BufferedReader(fr);

					boolean isHeader = true;
					String[] dadoSplit = null;
					String[] header = null;
					// equanto houver mais linhas
					while (br.ready()) {
						// lê a proxima linha
						String linha = br.readLine();

						if (isHeader) {
							header = linha.split(" ");
							isHeader = false;
							for (String h : header) {

								dados.put(h, null);
							}
						} else {
							dadoSplit = linha.split(" ");
							for (int i = 0; i < 5; i++) {// sao so 5 colunas

								ArrayList<String> list = dados.get(header[i]);

								if (list == null) {
									list = new ArrayList<String>();
								}

								list.add(dadoSplit[i]);
								dados.put(header[i], list);
							}
						}
					}

					// escreve no arquivo

					File saida = new File(pasta.getAbsolutePath() + "/saida/"
							+ f.getName());
					if (saida.createNewFile()) {// se conseguiu criar

						FileWriter fw = new FileWriter(saida, true);
						BufferedWriter bw = new BufferedWriter(fw);

						listHj = dados.get("HJ");
						listRvns = dados.get("RVNS");
						listUrvns = dados.get("URVNS");
						listBvns = dados.get("BVNS");
						listUbvns = dados.get("UBVNS");

						bw.write("HJ RVNS URVNS BVNS UBVNS");
						bw.newLine();
						while (true) {// so 5 colunas
							if (listHj.size() == 0) {// testa so com o primeiro,
														// eh
														// igual pro resto
								break;
							}
							String hj = listHj.get(0);
							String rvns = listRvns.get(0);
							String urvns = listUrvns.get(0);
							String bvns = listBvns.get(0);
							String ubvns = listUbvns.get(0);
							bw.write(hj + " " + rvns + " " + urvns + " " + bvns
									+ " " + ubvns);
							bw.newLine();

							listHj.remove(0);
							listRvns.remove(0);
							listUrvns.remove(0);
							listBvns.remove(0);
							listUbvns.remove(0);
						}
						bw.close();
						fw.close();
					}
					// faz algo com a linha
					// System.out.println(linha);

					br.close();
					fr.close();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
