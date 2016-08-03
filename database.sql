create table if not exists quarter_back
(
quarter_back_id bigserial,
name text not null,
passing_yard double precision not null,
passing_td double precision not null,
interception double precision not null,
rushing_yard double precision not null,
rushing_td double precision not null,
snake_adp double precision not null,
auction_value double precision not null,
auction_cost double precision not null,
company text not null,
CONSTRAINT "quarter_back_pk_quarter_back_id" PRIMARY KEY (quarter_back_id)
);

create table if not exists running_back
(
running_back_id bigserial,
name text not null,
receiving_yard double precision not null,
receiving_td double precision not null,
reception double precision not null,
rushing_yard double precision not null,
rushing_td double precision not null,
snake_adp double precision not null,
auction_value double precision not null,
auction_cost double precision not null,
company text not null,
CONSTRAINT "running_back_pk_running_back_id" PRIMARY KEY (running_back_id)
);

create table if not exists wide_receiving
(
wide_receiving_id bigserial,
name text not null,
receiving_yard double precision not null,
receiving_td double precision not null,
reception double precision not null,
rushing_yard double precision not null,
rushing_td double precision not null,
snake_adp double precision not null,
auction_value double precision not null,
auction_cost double precision not null,
company text not null,
CONSTRAINT "wide_receiving_pk_wide_receiving_id" PRIMARY KEY (wide_receiving_id)
);

create table if not exists tight_end
(
tight_end_id bigserial,
name text not null,
receiving_yard double precision not null,
receiving_td double precision not null,
reception double precision not null,
rushing_yard double precision not null,
rushing_td double precision not null,
snake_adp double precision not null,
auction_value double precision not null,
auction_cost double precision not null,
company text not null,
CONSTRAINT "tight_end_pk_tight_end_id" PRIMARY KEY (tight_end_id)
);

CREATE OR REPLACE FUNCTION quarter_back_upsert
(
  _name text,
  _passing_yard double precision,
  _passing_td double precision,
  _interception double precision,
  _rushing_yard double precision,
  _rushing_td double precision,
  _snake_adp double precision,
  _auction_value double precision,
  _auction_cost double precision,
  _company text
)
RETURNS int AS $$
DECLARE
	_quarter_back_id integer;
BEGIN
	SELECT quarter_back_id
	INTO _quarter_back_id
	FROM quarter_back
	WHERE name = _name;

	IF _quarter_back_id IS NULL THEN
		INSERT INTO quarter_back(name, passing_yard, passing_td, interception, rushing_yard, rushing_td, snake_adp,
		                         auction_vale, auction_cost, company)
		VALUES (_name, _passing_yard, _passing_td, _integration, _rushing_yard, _rushing_td, _snake_adp,
		        _auction_vale, _auction_cost, _company)
		RETURNING quarter_back_id INTO _quarter_back_id;
	ELSE
		UPDATE quarter_back
		SET name=_name, passing_yard=_passing_yard, passing_td=_passing_td, interception=_interception, rushing_yard=_rushing_yard,
		    rushing_td=_rushing_td, snake_adp=snake_adp, auction_vale=_auction_value, auction_cost=_auction_cost, company=_company
		WHERE quarter_back_id = _quarter_back_id;
	END IF;
	RETURN _quarter_back_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION running_back_upsert
(
  _name text,
  _receiving_yard double precision,
  _receiving_td double precision,
  _reception double precision,
  _rushing_yard double precision,
  _rushing_td double precision,
  _snake_adp double precision,
  _auction_value double precision,
  _auction_cost double precision,
  _company text
)
RETURNS int AS $$
DECLARE
	_running_back_id integer;
BEGIN
	SELECT running_back_id
	INTO _running_back_id
	FROM running_back
	WHERE name = _name;

	IF _running_back_id IS NULL THEN
		INSERT INTO running_back(name, receiving_yard, receiving_td, reception, rushing_yard, rushing_td, snake_adp,
		                         auction_vale, auction_cost, company)
		VALUES (_name, _receiving_yard, _receiving_td, _integration, _rushing_yard, _rushing_td, _snake_adp,
		        _auction_vale, _auction_cost, _company)
		RETURNING running_back_id INTO _running_back_id;
	ELSE
		UPDATE running_back
		SET name=_name, receiving_yard=_receiving_yard, receiving_td=_receiving_td, reception=_reception, rushing_yard=_rushing_yard,
		    rushing_td=_rushing_td, snake_adp=snake_adp, auction_vale=_auction_value, auction_cost=_auction_cost, company=_company
		WHERE running_back_id = _running_back_id;
	END IF;
	RETURN _running_back_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wide_receiver_upsert
(
  _name text,
  _receiving_yard double precision,
  _receiving_td double precision,
  _reception double precision,
  _rushing_yard double precision,
  _rushing_td double precision,
  _snake_adp double precision,
  _auction_value double precision,
  _auction_cost double precision,
  _company text
)
RETURNS int AS $$
DECLARE
	_wide_receiver_id integer;
BEGIN
	SELECT wide_receiver_id
	INTO _wide_receiver_id
	FROM wide_receiver
	WHERE name = _name;

	IF _wide_receiver_id IS NULL THEN
		INSERT INTO wide_receiver(name, receiving_yard, receiving_td, reception, rushing_yard, rushing_td, snake_adp,
		                         auction_vale, auction_cost, company)
		VALUES (_name, _receiving_yard, _receiving_td, reception, _rushing_yard, _rushing_td, _snake_adp,
		        _auction_vale, _auction_cost, _company)
		RETURNING wide_receiver_id INTO _wide_receiver_id;
	ELSE
		UPDATE wide_receiver
		SET name=_name, receiving_yard=_receiving_yard, receiving_td=_receiving_td, reception=_reception, rushing_yard=_rushing_yard,
		    rushing_td=_rushing_td, snake_adp=snake_adp, auction_vale=_auction_value, auction_cost=_auction_cost, company=_company
		WHERE wide_receiver_id = _wide_receiver_id;
	END IF;
	RETURN _wide_receiver_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tight_end_upsert
(
  _name text,
  _receiving_yard double precision,
  _receiving_td double precision,
  _reception double precision,
  _rushing_yard double precision,
  _rushing_td double precision,
  _snake_adp double precision,
  _auction_value double precision,
  _auction_cost double precision,
  _company text
)
RETURNS int AS $$
DECLARE
	_tight_end_id integer;
BEGIN
	SELECT tight_end_id
	INTO _tight_end_id
	FROM tight_end
	WHERE name = _name;

	IF _tight_end_id IS NULL THEN
		INSERT INTO tight_end(name, receiving_yard, receiving_td, reception, rushing_yard, rushing_td, snake_adp,
		                      auction_vale, auction_cost, company)
		VALUES (_name, _receiving_yard, _receiving_td, reception, _rushing_yard, _rushing_td, _snake_adp,
		        _auction_vale, _auction_cost, _company)
		RETURNING tight_end_id INTO _tight_end_id;
	ELSE
		UPDATE tight_end
		SET name=_name, receiving_yard=_receiving_yard, receiving_td=_receiving_td, reception=_reception, rushing_yard=_rushing_yard,
		    rushing_td=_rushing_td, snake_adp=snake_adp, auction_vale=_auction_value, auction_cost=_auction_cost, company=_company
		WHERE tight_end_id = _tight_end_id;
	END IF;
	RETURN _tight_end_id;
END;
$$ LANGUAGE plpgsql;

