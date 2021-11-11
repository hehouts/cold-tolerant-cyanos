import glob, os, re

GENE_ARRAY = ['aceE'
,'aceF'
,'csp'
,'deaD'
,'desA'
,'dnaA'
,'gyrA'
,'dnaK'
,'dnaJ'
,'hupB'
,'infA'
,'infB'
,'infC'
,'nusA'
,'otsA'
,'pnp'
,'rnr'
,'rbfA'
,'recA'
,'tig'
,'yfiA']
rawSequenceFilesDir = 'raw_sequence_files'
rawSequenceFilesExt = 'txt'

outputFileName = "output.csv"

class GenomeFileStripper():

    allGenomeDict = {} ## holds the dictionary of genome names and for each genome name there is a list of genes and counts

    showConsoleOutput = False ## print stuff will processing
    
    def __init__(self, showConsoleOutput):
        self.showConsoleOutput = showConsoleOutput


    def generateOutputFile(self):
        if self.showConsoleOutput:print("Generating output file");
        
        outF = open("output.csv", "w")
        
        ##Generate and write helpful header row
        csvHeaderLine = 'Genome'
        
        for currGene in GENE_ARRAY:
            csvHeaderLine += "," + currGene

        if self.showConsoleOutput:print("  " + csvHeaderLine)
        
        outF.write(csvHeaderLine + "\n");
    
        ##Generate and write counts row
        
        for genomeName in self.allGenomeDict:
            countsRow = genomeName;

            ## for this Genome, get the list of genes and the counts
            dictForGenome = self.allGenomeDict[genomeName]
            for geneName in dictForGenome : ## loop through the geneNames
                
                countsRow += "," + str(dictForGenome.get(geneName));
                
            if self.showConsoleOutput:print("  " + countsRow);                
            outF.write(countsRow + "\n");
            

    ##
    # Create and initialize a new Dictionary that has all the GENES and sets their count to 0
    # 'aceF', 0
    # 'csp', 0
    # ...
    # ...
    #
    def getDefaultGeneCountDictionary(self):
        newDefaultCountDict = {}
        
        # loop through GENE_ARRAY
        for currGene in GENE_ARRAY:
            newDefaultCountDict[currGene] = 0;
        
        return newDefaultCountDict;
        
    def processFiles(self):
        if self.showConsoleOutput:print("Processing files")


        self.allGenomeDict = {}
        fileCounter = 0;
        # iterating over all files
        for currFile in os.listdir(rawSequenceFilesDir):
            if currFile.endswith(rawSequenceFilesExt):
                fileCounter+=1;
                
                currFilePath = rawSequenceFilesDir + '/' + currFile
                if self.showConsoleOutput:print('  Processing ' + currFile);
                
                fileH = open(currFilePath, 'r')
                # >rbfA___new_hmms___d66e948d0f8a6692c1853d94a91c658883c8ddad9346138476a79298 bin_id:GCF_000757865.1_ASM75786v1_genomic|source:new_hmms|e_value:1.7e-37|contig:c_000000000001|gene_callers_id:180|start:169905|stop:170277|length:372
                for currLine in fileH:
                    if(currLine.startswith('>')): # main map point starts with '>'
                        ## genome should be same an unique in each file
                        genome = re.search('bin_id:(.+?)\|', currLine).group(1) # genome is in between bind_id: and '|' in line (must escape '|')
                        geneName = re.search('>(.+?)_', currLine).group(1) # gene is between the '>' and the first '_'

                        genomeCountDict = self.allGenomeDict.get(genome);
                        if(genomeCountDict is None): #this genome does not yet have a dictionary of counts
                            ## the big genomeDict does not have a dict yet for it's type, so get an empty one 
                            genomeCountDict = self.getDefaultGeneCountDictionary()
                            # and then add this to the big list by genome
                            self.allGenomeDict[genome] = genomeCountDict
                            
                        #at this point I have the dict with the keys of GENE_ARRAY
                        #for the 'geneName', pull the value from the dict, increment it, and put the new value in
                        genomeCountDict[geneName] = genomeCountDict[geneName] + 1;
                        ## if self.showConsoleOutput:print('    ' + geneName + ' : ' + str( genomeCountDict[geneName]));
                        
                
            else:
                continue
                
        if self.showConsoleOutput:print('  ' + str(fileCounter) + ' genome file(s) ' + 'processed');
                
if __name__ == "__main__":
    print("Starting genome file stripper")
    stripper = GenomeFileStripper(True) ## True to show stuff getting spit out to console, False for 'silent'
    stripper.processFiles()
    stripper.generateOutputFile()
    print("Genome file stripper finished.  Data written to : " + outputFileName);

                