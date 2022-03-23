///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class EpisodeListLinksSelf {
/*
{
  "href": "https://api.tvmaze.com/episodes/1"
} 
*/

  String? href;

  EpisodeListLinksSelf({
    this.href,
  });
  EpisodeListLinksSelf.fromJson(Map<String, dynamic> json) {
    href = json['href']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class EpisodeListLinks {
/*
{
  "self": {
    "href": "https://api.tvmaze.com/episodes/1"
  }
} 
*/

  EpisodeListLinksSelf? self;

  EpisodeListLinks({
    this.self,
  });
  EpisodeListLinks.fromJson(Map<String, dynamic> json) {
    self = (json['self'] != null)
        ? EpisodeListLinksSelf.fromJson(json['self'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.toJson();
    }
    return data;
  }
}

class EpisodeListImage {
/*
{
  "medium": "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
  "original": "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
} 
*/

  String? medium;
  String? original;

  EpisodeListImage({
    this.medium,
    this.original,
  });
  EpisodeListImage.fromJson(Map<String, dynamic> json) {
    medium = json['medium']?.toString();
    original = json['original']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['medium'] = medium;
    data['original'] = original;
    return data;
  }
}

class EpisodeListRating {
/*
{
  "average": 7.7
} 
*/

  double? average;

  EpisodeListRating({
    this.average,
  });
  EpisodeListRating.fromJson(Map<String, dynamic> json) {
    average = json['average']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['average'] = average;
    return data;
  }
}

class EpisodeList {
/*
{
  "id": 1,
  "url": "https://www.tvmaze.com/episodes/1/under-the-dome-1x01-pilot",
  "name": "Pilot",
  "season": 1,
  "number": 1,
  "type": "regular",
  "airdate": "2013-06-24",
  "airtime": "22:00",
  "airstamp": "2013-06-25T02:00:00+00:00",
  "runtime": 60,
  "rating": {
    "average": 7.7
  },
  "image": {
    "medium": "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
    "original": "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
  },
  "summary": "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
  "_links": {
    "self": {
      "href": "https://api.tvmaze.com/episodes/1"
    }
  }
} 
*/

  int? id;
  String? url;
  String? name;
  int? season;
  int? number;
  String? type;
  String? airdate;
  String? airtime;
  String? airstamp;
  int? runtime;
  EpisodeListRating? rating;
  EpisodeListImage? image;
  String? summary;
  EpisodeListLinks? Links;

  EpisodeList({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.type,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.rating,
    this.image,
    this.summary,
    this.Links,
  });
  EpisodeList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    url = json['url']?.toString();
    name = json['name']?.toString();
    season = json['season']?.toInt();
    number = json['number']?.toInt();
    type = json['type']?.toString();
    airdate = json['airdate']?.toString();
    airtime = json['airtime']?.toString();
    airstamp = json['airstamp']?.toString();
    runtime = json['runtime']?.toInt();
    rating = (json['rating'] != null)
        ? EpisodeListRating.fromJson(json['rating'])
        : null;
    image = (json['image'] != null)
        ? EpisodeListImage.fromJson(json['image'])
        : null;
    summary = json['summary']?.toString();
    Links = (json['_links'] != null)
        ? EpisodeListLinks.fromJson(json['_links'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['season'] = season;
    data['number'] = number;
    data['type'] = type;
    data['airdate'] = airdate;
    data['airtime'] = airtime;
    data['airstamp'] = airstamp;
    data['runtime'] = runtime;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
    if (Links != null) {
      data['_links'] = Links!.toJson();
    }
    return data;
  }
}