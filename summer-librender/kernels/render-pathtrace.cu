#pragma once


#include "helpers.cuh"


namespace Summer {


/*enum RAY_TYPE {
	PRIMARY = 0,
	SHADOW  = 1
};*/


extern "C" __global__ void __miss__pathtrace() {
	uint32_t index = optixGetPayload_0();
	interface.camera.framebuffer.rgba.ptr[index] = pack_sRGB_A(Vec4f( Vec3f(0.5f), 1.0f ));
}


extern "C" __global__ void __closesthit__pathtrace() {
	DataSBT_HitOps const& data = *reinterpret_cast<DataSBT_HitOps*>(optixGetSbtDataPointer());
	Scene::ShadePoint shade_point = get_shade_info(data);

	//write_rgba(Vec4f( shade_point.bary, 1.0f ));
	//write_rgba(Vec4f( shade_point.texc0,0.0f, 1.0f ));
	//write_rgba(Vec4f( Vec3f(shade_point.texc0.y), 1.0f ));
	//write_rgba(Vec4f( shade_point.Ngeom, 1.0f ));
	//write_rgba(Vec4f( shade_point.Nshad, 1.0f ));

	//write_rgba(Vec4f( Vec3f(data.sbtentry_index/20.0f), 1.0f ));

	//unsigned int prim_index = optixGetPrimitiveIndex();
	//write_rgba(Vec4f( Vec3f(prim_index/50000.0f), 1.0f ));

	/*Vec3u indices = calc_indices(data);
	if (indices.x==0) {
		write_rgba(Vec4f( 1,0,1, 1.0f ));
	} else {
		write_rgba(Vec4f( Vec3f(indices)*0.4f, 1.0f ));
	}*/

	/*switch (data.material_index) {
		case 0:  write_rgba(Vec4f(1,0,0,1)); break;
		case 1:  write_rgba(Vec4f(0,1,0,1)); break;
		default: write_rgba(Vec4f(1,0,1,1)); break;
	}*/

	#if 0
		Vec4f albedo = shade_point.material->get_albedo(&shade_point);
		albedo.a = 1.0f;
		write_rgba(albedo);
	#endif
	#if 1
		Vec3f L = glm::normalize(Vec3f(1,2,1));
		float3 Vtmp = optixGetWorldRayDirection();
		Vec3f V = -Vec3f(Vtmp.x,Vtmp.y,Vtmp.z);

		Scene::ShadePointEvaluate hit = { shade_point, L,V };
		Vec4f bsdf = shade_point.material->evaluate(&hit);
		bsdf.a = 1.0f;

		#if 1
			Vec3f Li = Vec3f(20.0f);

			Vec3f Lo = Li * Vec3f(bsdf) * glm::dot(L,shade_point.Nshad);
			Lo += shade_point.material->emission(&shade_point);

			write_rgba(Vec4f(Lo,1.0f));
		#else
			write_rgba(bsdf);
		#endif
	#endif
}

extern "C" __global__ void __anyhit__pathtrace() {
	uint32_t index = optixGetPayload_0();
	interface.camera.framebuffer.rgba.ptr[index] = pack_sRGB_A(Vec4f( 0.5f,0.0f,0.0f, 1.0f ));
}

  
}
