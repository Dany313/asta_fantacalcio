// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClubCollection on Isar {
  IsarCollection<Club> get clubs => this.collection();
}

const ClubSchema = CollectionSchema(
  name: r'Club',
  id: -553451813013271185,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'managerName': PropertySchema(
      id: 1,
      name: r'managerName',
      type: IsarType.string,
    ),
    r'remainBudget': PropertySchema(
      id: 2,
      name: r'remainBudget',
      type: IsarType.long,
    )
  },
  estimateSize: _clubEstimateSize,
  serialize: _clubSerialize,
  deserialize: _clubDeserialize,
  deserializeProp: _clubDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'players': LinkSchema(
      id: 3887893242643144524,
      name: r'players',
      target: r'Player',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _clubGetId,
  getLinks: _clubGetLinks,
  attach: _clubAttach,
  version: '3.1.0+1',
);

int _clubEstimateSize(
  Club object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.managerName.length * 3;
  return bytesCount;
}

void _clubSerialize(
  Club object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeString(offsets[1], object.managerName);
  writer.writeLong(offsets[2], object.remainBudget);
}

Club _clubDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Club(
    managerName: reader.readString(offsets[1]),
    remainBudget: reader.readLong(offsets[2]),
  );
  object.id = id;
  return object;
}

P _clubDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _clubGetId(Club object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _clubGetLinks(Club object) {
  return [object.players];
}

void _clubAttach(IsarCollection<dynamic> col, Id id, Club object) {
  object.id = id;
  object.players.attach(col, col.isar.collection<Player>(), r'players', id);
}

extension ClubQueryWhereSort on QueryBuilder<Club, Club, QWhere> {
  QueryBuilder<Club, Club, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClubQueryWhere on QueryBuilder<Club, Club, QWhereClause> {
  QueryBuilder<Club, Club, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Club, Club, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Club, Club, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Club, Club, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClubQueryFilter on QueryBuilder<Club, Club, QFilterCondition> {
  QueryBuilder<Club, Club, QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'managerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'managerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'managerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerName',
        value: '',
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> managerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'managerName',
        value: '',
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> remainBudgetEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remainBudget',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> remainBudgetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remainBudget',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> remainBudgetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remainBudget',
        value: value,
      ));
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> remainBudgetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remainBudget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClubQueryObject on QueryBuilder<Club, Club, QFilterCondition> {}

extension ClubQueryLinks on QueryBuilder<Club, Club, QFilterCondition> {
  QueryBuilder<Club, Club, QAfterFilterCondition> players(
      FilterQuery<Player> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'players');
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> playersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, true, length, true);
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> playersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, 0, true);
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> playersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, false, 999999, true);
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> playersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, length, include);
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> playersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, include, 999999, true);
    });
  }

  QueryBuilder<Club, Club, QAfterFilterCondition> playersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'players', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ClubQuerySortBy on QueryBuilder<Club, Club, QSortBy> {
  QueryBuilder<Club, Club, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> sortByManagerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> sortByManagerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.desc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> sortByRemainBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainBudget', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> sortByRemainBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainBudget', Sort.desc);
    });
  }
}

extension ClubQuerySortThenBy on QueryBuilder<Club, Club, QSortThenBy> {
  QueryBuilder<Club, Club, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenByManagerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenByManagerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerName', Sort.desc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenByRemainBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainBudget', Sort.asc);
    });
  }

  QueryBuilder<Club, Club, QAfterSortBy> thenByRemainBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainBudget', Sort.desc);
    });
  }
}

extension ClubQueryWhereDistinct on QueryBuilder<Club, Club, QDistinct> {
  QueryBuilder<Club, Club, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<Club, Club, QDistinct> distinctByManagerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'managerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Club, Club, QDistinct> distinctByRemainBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remainBudget');
    });
  }
}

extension ClubQueryProperty on QueryBuilder<Club, Club, QQueryProperty> {
  QueryBuilder<Club, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Club, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<Club, String, QQueryOperations> managerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'managerName');
    });
  }

  QueryBuilder<Club, int, QQueryOperations> remainBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remainBudget');
    });
  }
}
