#ifndef _NEURAL_NETWORK_H_
#define _NEURAL_NETWORK_H_

#include "neuron.h"

struct sNeuralNetworkInitStructure
{
	u32 init_vector_size;
	u32 *init_vector;

	float weight_range, learning_constant;
	
	u32 order, neuron_type;
};

struct sNeuralNetwork
{
	u32 layers_count, order;
	u32 *size_input, *size_input_;
	u32 *size_output;

	float learning_constant;
	float weight_range;

	float ***w;
	float **output;
	float **error;

	float **input;
	float **input_;
};

void NeuralNetworkInitStructure_init(
										struct sNeuralNetworkInitStructure *nn_init_structure, 
										u32 init_vector_size,
										float weight_range,
										u32 order,
										u32 neuron_type,
										float learning_constant
									);

void NeuralNetworkInitStructure_uninit(struct sNeuralNetworkInitStructure *nn_init_structure);





class CNeuralNetwork
{
	private:	
		struct sNeuralNetwork nn;

		std::vector<float> input;
		std::vector<float> output;
	public:
	
		CNeuralNetwork(struct sNeuralNetworkInitStructure nn_init_structure);
		~CNeuralNetwork();

		void process(std::vector<float> input);
		std::vector<float> get();
		
		void learn(std::vector<float> required_output);

	private:
	
		float rnd();
};

#endif