// ignore_for_file: constant_identifier_names

enum RankType {
  Year2002,
  Year2003,
  Year2004,
  Year2005,
  Year2006,
  Year2007,
  Year2008,
  Year2009,
  Year2010,
  Year2011,
  Year2012,
  Year2013,
  Year2014,
  Year2015,
  Year2016,
  Year2017,
  Year2018,
  Year2019,
  Year2020,
  Year2021,
  Last12months,
  Last6months,
  Last3months,
  Last30days,
  Last7days,
  AverageRating,
  MostRatings,
  Trendingpast12months,
  Trendingpast6months,
  Trendingpast3months,
  Trendingpast30days,
  Trendingpast7days,
}

String getType({
  required RankType type,
}) {
  switch (type) {
    case RankType.Year2002:
      return 'Year 2002';
    case RankType.Year2003:
      return 'Year 2003';
    case RankType.Year2004:
      return 'Year 2004';
    case RankType.Year2005:
      return 'Year 2005';
    case RankType.Year2006:
      return 'Year 2006';
    case RankType.Year2007:
      return 'Year 2007';
    case RankType.Year2008:
      return 'Year 2008';
    case RankType.Year2009:
      return 'Year 2009';
    case RankType.Year2010:
      return 'Year 2010';
    case RankType.Year2011:
      return 'Year 2011';
    case RankType.Year2012:
      return 'Year 2012';
    case RankType.Year2013:
      return 'Year 2013';
    case RankType.Year2014:
      return 'Year 2014';
    case RankType.Year2015:
      return 'Year 2015';
    case RankType.Year2016:
      return 'Year 2016';
    case RankType.Year2017:
      return 'Year 2017';
    case RankType.Year2018:
      return 'Year 2018';
    case RankType.Year2019:
      return 'Year 2019';
    case RankType.Year2020:
      return 'Year 2020';
    case RankType.Year2021:
      return 'Year 2021';
    case RankType.Last12months:
      return 'Last 12 months';
    case RankType.Last6months:
      return 'Last 6 months';
    case RankType.Last3months:
      return 'Last 3 months';
    case RankType.Last30days:
      return 'Last 30 days';
    case RankType.Last7days:
      return 'Last 7 days';
    case RankType.AverageRating:
      return 'Average Rating';
    case RankType.MostRatings:
      return 'Most Ratings';
    case RankType.Trendingpast12months:
      return 'Trending past 12 months';
    case RankType.Trendingpast6months:
      return 'Trending past 6 months';
    case RankType.Trendingpast3months:
      return 'Trending past 3 months';
    case RankType.Trendingpast30days:
      return 'Trending past 30 days';
    case RankType.Trendingpast7days:
      return 'Trending past 7 days';
  }
}
