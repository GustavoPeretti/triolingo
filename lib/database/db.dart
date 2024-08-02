import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'triolingo.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute('CREATE TABLE palavras (idPalavra INTEGER PRIMARY KEY AUTOINCREMENT, grafiaPortugues TEXT, grafiaIngles TEXT, grafiaLatim TEXT, significadoPortugues TEXT, significadoIngles TEXT, significadoLatim TEXT);');
      db.execute('CREATE TABLE traducoes (lingua TEXT PRIMARY KEY, mensagemInicial TEXT, comandoLingua TEXT, portugues TEXT, ingles TEXT, latim TEXT, desejoAprimorar TEXT, conhecoPalavras TEXT, paraRevisar TEXT, palavrasConhecidas TEXT, configuracoes TEXT, alterarLingua TEXT, linguaAtual TEXT, conheco TEXT, naoConheco TEXT);');
      db.execute('CREATE TABLE preferencias (lingua TEXT);');
      db.execute('CREATE TABLE conhecidas (idPalavra INTEGER, linguaPadrao TEXT, linguaEscolhida TEXT);');
      db.execute('CREATE TABLE revisao (idPalavra INTEGER, linguaPadrao TEXT, linguaEscolhida TEXT);');
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Livro', 'Book', 'Liber', 'Conjunto de folhas impressas ou manuscritas encadernadas.', 'A set of written, printed, or blank pages fastened together along one side and encased between protective covers.', 'Liber est volumen scriptum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Mesa', 'Table', 'Mensa', 'Móvel com tampo plano sustentado por pés, usado para diversas atividades.', 'A piece of furniture with a flat top and one or more legs, providing a level surface for eating, writing, or working.', 'Mensa est superficies ad cibum sumendum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Janela', 'Window', 'Fenestra', 'Abertura em uma parede para entrada de luz e ar.', 'An opening in the wall or roof of a building or vehicle that is fitted with glass or other transparent material to admit light or air and allow people to see out.', 'Fenestra est apertura in pariete.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Sol', 'Sun', 'Sol', 'Estrela central do sistema solar que fornece luz e calor.', 'The star around which the earth orbits.', 'Sol est astra in caelo quod lucem dat.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Coração', 'Heart', 'Cor', 'Órgão muscular que bombeia sangue pelo corpo.', 'A hollow muscular organ that pumps the blood through the circulatory system by rhythmic contraction and dilation.', 'Cor est organum in corpore humano quod sanguinem pervenit.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Amizade', 'Friendship', 'Amicitia', 'Relação afetiva entre amigos.', 'The emotions or conduct of friends; the state of being friends.', 'Amicitia est relatio inter duos homines.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Estrela', 'Star', 'Stella', 'Corpo celeste que brilha no céu.', 'A fixed luminous point in the night sky that is a large, remote incandescent body like the sun.', 'Stella est corpus caeleste quod lucet in nocte.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Relógio', 'Clock', 'Horologium', 'Instrumento usado para medir o tempo.', 'A mechanical or electrical device for measuring time, typically by hands on a round dial or by displayed figures.', 'Horologium est instrumentum ad tempus mensurandum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Música', 'Music', 'Musica', 'Arte de combinar sons de forma harmoniosa.', 'Vocal or instrumental sounds (or both) combined in such a way as to produce beauty of form, harmony, and expression of emotion.', 'Musica est ars sonorum ordinata.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Floresta', 'Forest', 'Silva', 'Grande área de terra coberta por árvores e vegetação.', 'A large area covered chiefly with trees and undergrowth.', 'Silva est locus ubi multae plantae crescunt.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Lápis', 'Pencil', 'Stilus', 'Instrumento de escrita feito de grafite.', 'An instrument for writing or drawing, typically consisting of a thin stick of graphite or a similar substance enclosed in a long thin piece of wood or held in a metal or plastic case.', 'Stilus est instrumentum ad scribendum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Montanha', 'Mountain', 'Mons', 'Grande elevação natural do terreno.', 'A large natural elevation of the surface of the earth rising abruptly from the surrounding level; a large steep hill.', 'Mons est alta collis vel montis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Caminho', 'Path', 'Via', 'Passagem ou percurso que leva a um destino.', 'A way or track laid down for walking or made by continual treading.', 'Via est iter vel semita.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Alegria', 'Joy', 'Laetitia', 'Sentimento de felicidade e contentamento.', 'A feeling of great pleasure and happiness.', 'Laetitia est status animi gaudii.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Silêncio', 'Silence', 'Silentium', 'Ausência de som.', 'Complete absence of sound.', 'Silentium est absens sonorum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Luz', 'Light', 'Lux', 'Radiação visível que permite a visão.', 'The natural agent that stimulates sight and makes things visible.', 'Lux est visibilis radiatio quae illuminat.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Céu', 'Sky', 'Caelum', 'Espaço acima da Terra onde estão o sol, a lua e as estrelas.', 'The region of the atmosphere and outer space seen from the earth.', 'Caelum est spatium supra terram ubi stellas videamus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Mar', 'Sea', 'Mare', 'Grande massa de água salgada que cobre parte da superfície da Terra.', 'The expanse of salt water that covers most of the surface of the earth and surrounds its landmasses.', 'Mare est vastum aquae corpus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Vento', 'Wind', 'Ventus', 'Movimento natural do ar.', 'The perceptible natural movement of the air, especially in the form of a current of air blowing from a particular direction.', 'Ventus est aeris motus in atmosphaera.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Sonho', 'Dream', 'Somnium', 'Sequência de imagens e pensamentos que ocorrem durante o sono.', 'A series of thoughts, images, and sensations occurring inside the mind of a person during sleep.', 'Somnium est imaginatio quae in somno fit.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Sombra', 'Shadow', 'Umbra', 'Área escura formada pela ausência de luz.', 'A dark area or shape produced by a body coming between rays of light and a surface.', 'Umbra est pars obscura quae a lumine impeditur.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Flores', 'Flowers', 'Flores', 'Parte reprodutiva das plantas.', 'The seed-bearing part of a plant, consisting of reproductive organs (stamens and carpels) that are typically surrounded by a brightly colored corolla (petals) and a green calyx (sepals).', 'Flores sunt partes plantae quae seminibus generant.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Árvore', 'Tree', 'Arbor', 'Planta de tronco lenhoso e geralmente elevado.', 'A perennial plant with an elongated stem, or trunk, supporting branches and leaves.', 'Arbor est planta cum trunco longo.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Terra', 'Earth', 'Terra', 'Planeta onde vivemos.', 'The planet on which we live; the world.', 'Terra est planeta in quo vivimus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Lua', 'Moon', 'Luna', 'Satélite natural da Terra.', 'The natural satellite of the earth, visible (chiefly at night) by reflected light from the sun.', 'Luna est planeta qui circum terram orbitam facit.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Esperança', 'Hope', 'Spes', 'Sentimento de expectativa positiva em relação ao futuro.', 'A feeling of expectation and desire for a certain thing to happen.', 'Spes est exspectatio bonorum futurorum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Casa', 'House', 'Domus', 'Edificação usada como moradia.', 'A building for human habitation, especially one that is lived in by a family or small group of people.', 'Domus est locum ubi habitamus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Carro', 'Car', 'Currus', 'Veículo automotor usado para transporte.', 'A road vehicle, typically with four wheels, powered by an internal combustion engine and able to carry a small number of people.', 'Currus est vehiculum rotis vehendum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Rua', 'Street', 'Via', 'Via pública em uma cidade ou vila.', 'A public road in a city or town, typically with houses and buildings on one or both sides.', 'Via est semita vel strada per quam vehicula transit.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Cidade', 'City', 'Urbs', 'Grande aglomerado urbano com várias infraestruturas.', 'A large town.', 'Urbs est locus habitationis urbanus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Escola', 'School', 'Schola', 'Instituição de ensino onde se ministram aulas.', 'An institution for educating children.', 'Schola est locus ubi discimus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Trabalho', 'Work', 'Labor', 'Atividade que envolve esforço mental ou físico com um propósito.', 'Activity involving mental or physical effort done in order to achieve a purpose or result.', 'Labor est actus laboris vel opus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Família', 'Family', 'Familia', 'Grupo de pessoas relacionadas por laços de parentesco.', 'A group consisting of parents and children living together in a household.', 'Familia est coetus hominum qui connexi sunt.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Amigo', 'Friend', 'Amicus', 'Pessoa com quem se tem uma relação de amizade.', 'A person whom one knows and with whom one has a bond of mutual affection, typically exclusive of sexual or family relations.', 'Amicus est persona qua amicitia inter nos est.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Comida', 'Food', 'Cibus', 'Qualquer substância que se ingere para nutrição.', 'Any nutritious substance that people or animals eat or drink or that plants absorb in order to maintain life and growth.', 'Cibus est materia ad alimentum edendum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Bebida', 'Drink', 'Potio', 'Líquido que se pode beber.', 'Take (a liquid) into the mouth and swallow.', 'Potio est liquorem bibendum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Água', 'Water', 'Aqua', 'Substância líquida essencial para a vida.', 'A colorless, transparent, odorless liquid that forms the seas, lakes, rivers, and rain and is the basis of the fluids of living organisms.', 'Aqua est substantia liquida essentialis vitae.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Fogo', 'Fire', 'Ignis', 'Combustão visível caracterizada por calor e luz.', 'Combustion or burning, in which substances combine chemically with oxygen from the air and typically give out bright light, heat, and smoke.', 'Ignis est flamma vel calor incendii.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Anjo', 'Angel', 'Angelus', 'Ser espiritual frequentemente representado como um mensageiro divino.', 'A spiritual being believed to act as an attendant, agent, or messenger of God.', 'Angelus est spiritualis entitas nuntius divinus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Vida', 'Life', 'Vita', 'Estado de existência que distingue os organismos vivos dos não vivos.', 'The condition that distinguishes animals and plants from inorganic matter, including the capacity for growth, reproduction, functional activity, and continual change preceding death.', 'Vita est status existendi qui organismis vitalibus distinguitur.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Morte', 'Death', 'Mors', 'Fim da vida.', 'The end of the life of a person or organism.', 'Mors est finis vitae.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Saudade', 'Nostalgia', 'Desiderium', 'Sentimento melancólico de lembrar de algo ou alguém distante.', 'A sentimental longing or wistful affection for a period in the past.', 'Desiderium est affectus melancholicus praeteriti temporis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Paz', 'Peace', 'Pax', 'Estado de tranquilidade e harmonia.', 'Freedom from disturbance; tranquility.', 'Pax est status tranquillitatis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Guerra', 'War', 'Bellum', 'Conflito armado entre nações ou grupos.', 'A state of armed conflict between different countries or different groups within a country.', 'Bellum est conflictus armatus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Criança', 'Child', 'Puer', 'Pessoa jovem ainda em desenvolvimento.', 'A young human being below the age of puberty or below the legal age of majority.', 'Puer est persona juvenis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Adulto', 'Adult', 'Adultus', 'Pessoa madura plenamente desenvolvida.', 'A person who is fully grown or developed.', 'Adultus est persona plenae maturationis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Noite', 'Night', 'Nox', 'Período de escuridão entre o pôr do sol e o nascer do sol.', 'The period of darkness in each twenty-four hours; the time from sunset to sunrise.', 'Nox est tempus obscurum inter solis occasum et ortum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Dia', 'Day', 'Dies', 'Período de 24 horas.', 'A period of twenty-four hours as a unit of time, reckoned from one midnight to the next, corresponding to a rotation of the earth on its axis.', 'Dies est spatium viginti quattuor horarum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Mãe', 'Mother', 'Mater', 'Mulher que deu à luz ou cria um filho.', 'A woman in relation to her child or children.', 'Mater est mulier quae filium vel filiam genuit.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Pai', 'Father', 'Pater', 'Homem que gerou um filho.', 'A man in relation to his child or children.', 'Pater est vir qui filium vel filiam genuit.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Irmão', 'Brother', 'Frater', 'Pessoa do sexo masculino que tem os mesmos pais que outra pessoa.', 'A man or boy in relation to other sons and daughters of his parents.', 'Frater est masculus qui eadem parentibus natus est.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Irmã', 'Sister', 'Soror', 'Pessoa do sexo feminino que tem os mesmos pais que outra pessoa.', 'A woman or girl in relation to other daughters and sons of her parents.', 'Soror est femina quae eadem parentibus nata est.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Amor', 'Love', 'Amor', 'Sentimento intenso de afeto e carinho.', 'An intense feeling of deep affection.', 'Amor est affectus intensus et dilectio.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Ódio', 'Hate', 'Oditio', 'Sentimento intenso de aversão e antipatia.', 'Intense dislike or ill will.', 'Oditio est aversio et inimicitia intensa.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Riqueza', 'Wealth', 'Opulentia', 'Abundância de bens materiais e dinheiro.', 'An abundance of valuable possessions or money.', 'Opulentia est abundantia rerum materialium et pecuniae.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Pobreza', 'Poverty', 'Paupertas', 'Estado de extrema carência de recursos materiais.', 'The state of being extremely poor.', 'Paupertas est status extremae inopiae rerum materialium.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Liberdade', 'Freedom', 'Libertas', 'Estado de não estar sujeito a restrições.', 'The power or right to act, speak, or think as one wants without hindrance or restraint.', 'Libertas est status absens restrictionis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Escravidão', 'Slavery', 'Servitus', 'Condição de ser propriedade de outra pessoa e ser forçado a trabalhar sem remuneração.', 'The state of being a slave.', 'Servitus est conditio sub dominio alicuius et laborandi sine mercede.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Justiça', 'Justice', 'Iustitia', 'Qualidade de ser justo e imparcial.', 'Just behavior or treatment.', 'Iustitia est qualitas aequitatis et impartialitatis.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Injustiça', 'Injustice', 'Iniuria', 'Ação ou tratamento injusto.', 'Lack of fairness or justice.', 'Iniuria est actus vel tractatus iniquus.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Cultura', 'Culture', 'Cultura', 'Conjunto de conhecimentos, crenças e comportamentos de um grupo.', 'The arts and other manifestations of human intellectual achievement regarded collectively.', 'Cultura est coetus scientiarum, credentiarum et morum gregis hominum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Religião', 'Religion', 'Religio', 'Sistema de crenças e práticas relacionadas ao sagrado.', 'The belief in and worship of a superhuman controlling power, especially a personal God or gods.', 'Religio est systema credentiarum et praxium quae ad sacrum referuntur.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Arte', 'Art', 'Ars', 'Expressão criativa através de diversas formas como pintura, escultura, música, etc.', 'The expression or application of human creative skill and imagination, typically in a visual form such as painting or sculpture.', 'Ars est expressio creativa per diversas formas ut picturam, sculpturam, musicam, etc.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Ciência', 'Science', 'Scientia', 'Conjunto de conhecimentos obtidos através da observação e experimentação.', 'The intellectual and practical activity encompassing the systematic study of the structure and behavior of the physical and natural world through observation and experiment.', 'Scientia est coetus cognitionum per observationem et experimentum acquisitarum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Filosofia', 'Philosophy', 'Philosophia', 'Estudo dos fundamentos da existência, conhecimento e valores.', 'The study of the fundamental nature of knowledge, reality, and existence.', 'Philosophia est studium fundamentorum existentiae, cognitionis et valorum.');");
      db.execute("INSERT INTO palavras (grafiaPortugues, grafiaIngles, grafiaLatim, significadoPortugues, significadoIngles, significadoLatim) VALUES ('Tecnologia', 'Technology', 'Technologia', 'Aplicação de conhecimentos científicos para fins práticos.', 'The application of scientific knowledge for practical purposes.', 'Technologia est applicatio scientiarum ad usus practicos.');");
      db.execute("INSERT INTO traducoes (lingua, mensagemInicial, comandoLingua, portugues, ingles, latim, desejoAprimorar, conhecoPalavras, paraRevisar, palavrasConhecidas, configuracoes, alterarLingua, linguaAtual, conheco, naoConheco) VALUES ('portugues', 'Vocabulário: seu tesouro de ferramentas!', 'Selecione sua língua principal', 'Português', 'Inglês', 'Latim', 'Quero aprimorar meu vocabulário em:', 'Conheço x palavras', 'Palavras para revisar', 'Palavras conhecidas', 'Configurações', 'Alterar língua de preferência', 'Atual', 'Conheço', 'Não conheço');");
      db.execute("INSERT INTO traducoes (lingua, mensagemInicial, comandoLingua, portugues, ingles, latim, desejoAprimorar, conhecoPalavras, paraRevisar, palavrasConhecidas, configuracoes, alterarLingua, linguaAtual, conheco, naoConheco) VALUES ('ingles', 'Vocabulary: your treasure of tools!', 'Select your main language', 'Portuguese', 'English', 'Latin', 'I want to improve my vocabulary in:', 'I know x words', 'Words to review', 'Known words', 'Settings', 'Change preferred language', 'Current', 'I know', 'I do not know');");
      db.execute("INSERT INTO traducoes (lingua, mensagemInicial, comandoLingua, portugues, ingles, latim, desejoAprimorar, conhecoPalavras, paraRevisar, palavrasConhecidas, configuracoes, alterarLingua, linguaAtual, conheco, naoConheco) VALUES ('latim', 'Vocabularium: thesaurus tuus instrumentorum!', 'Elige linguam tuam principalem', 'Lusitanice', 'Anglice', 'Latine', 'Volo augere vocabularium meum in:', 'Novi x verba', 'Verba revisenda', 'Verba nota', 'Configurationes', 'Mutare linguam praelatam', 'Praesens', 'Novi', 'Non novi');");
    },
  );
}