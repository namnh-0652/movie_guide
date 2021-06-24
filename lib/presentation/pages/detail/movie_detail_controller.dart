import 'package:get/get.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/data/repository/remote/api/error/api_error.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movieguide/presentation/base/process_state.dart';
import 'package:movieguide/shared/constant.dart';

class MovieDetailController extends GetxController {
  final GetMovieDetailUseCase getMovieDetailUseCase;

  MovieDetailController({required this.getMovieDetailUseCase});

  final _movieDetail = Rx<MovieDetail?>(null);
  get movieDetail => this._movieDetail.value;
  set movieDetail(value) => this._movieDetail.value = value;

  final _getMovieDetailState = Rx<ProcessState?>(null);
  get getMovieDetailState => this._getMovieDetailState.value;
  set getMovieDetailState(value) => this._getMovieDetailState.value = value;

  @override
  void onInit() {
    super.onInit();
    final movieId = Get.arguments["movieId"];
    _getMovieDetail(movieId);
  }

  void _getMovieDetail(int movieId) async {
    getMovieDetailState = ProcessState.loading();

    final response = await getMovieDetailUseCase(
      GetMovieDetailUseCaseParams(
        apiKey: ApiConfig.API_KEY,
        movieId: movieId,
      ),
    );

    response.fold(
      (failure) {
        getMovieDetailState = ProcessState.error(_mapErrorToString(failure));
      },
      (data) {
        _movieDetail.value = data;
        getMovieDetailState = ProcessState.success(movieDetail);
      },
    );
  }

  String _mapErrorToString(ErrorEntity failure) {
    switch (failure.runtimeType) {
      case NetworkError:
        return NETWORK_ERROR;
      case ServerError:
        return SERVER_ERROR;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}
