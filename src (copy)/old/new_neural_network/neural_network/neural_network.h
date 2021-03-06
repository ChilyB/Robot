#ifndef _NEURAL_NETWORK_H_
#define _NEURAL_NETWORK_H_

#include "../common.h"


#define NEURON_TYPE_COMMON	((u32)1)
#define NEURON_TYPE_TAYLOR	((u32)2)
#define NEURON_TYPE_MIXED	((u32)3)

struct sNeuralNetworkInitStructure
{
	u32 init_vector_size;
	u32 *init_vector;

	float weight_range;
	float learning_constant_eta, learning_constant_gamma;
	
	u32 order, neuron_type;
};

struct sNeuralNetwork
{
	u32 neuron_type;
	
	u32 layers_count, order;
	u32 *size_input, *size_input_;
	u32 *size_output;

	float learning_constant_eta, learning_constant_gamma;
	float weight_range;

	float ***w;
	float **output;
	float **error;
	float **error_prev;

	float **input;
	float **input_;
	float **input_prev_;
};

void NeuralNetworkInitStructure_init(
										struct sNeuralNetworkInitStructure *nn_init_structure, 
										u32 init_vector_size,
										float weight_range,
										u32 order,
										u32 neuron_type,

										float learning_constant_eta, float learning_constant_gamma
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