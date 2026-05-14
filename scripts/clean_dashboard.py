#!/usr/bin/env python3
"""
clean_dashboard.py

Strips server-side metadata from a Grafana dashboard JSON export so it can be
used with Terraform's grafana_dashboard resource (k8s-style v2 API).

Usage:
    python3 scripts/clean_dashboard.py terraform/dashboards/hackday.json

Optionally replace a datasource name:
    python3 scripts/clean_dashboard.py terraform/dashboards/hackday.json \
        --replace-datasource bflygz5msh0cga TestData
"""

import argparse
import json
import sys


METADATA_KEYS_TO_REMOVE = [
    "namespace",
    "uid",
    "resourceVersion",
    "generation",
    "creationTimestamp",
    "labels",       
    "annotations", 
]


def clean(data: dict, replace_datasource: tuple | None) -> dict:
    if "metadata" in data:
        for key in METADATA_KEYS_TO_REMOVE:
            data["metadata"].pop(key, None)

    if replace_datasource:
        old_name, new_name = replace_datasource
        data = replace_in(data, old_name, new_name)

    return data


def replace_in(obj, old: str, new: str):
    if isinstance(obj, dict):
        return {k: replace_in(v, old, new) for k, v in obj.items()}
    if isinstance(obj, list):
        return [replace_in(item, old, new) for item in obj]
    if isinstance(obj, str) and obj == old:
        return new
    return obj


def main():
    parser = argparse.ArgumentParser(description="Clean a Grafana dashboard JSON for Terraform use.")
    parser.add_argument("file", help="Path to the dashboard JSON file (edited in place)")
    parser.add_argument(
        "--replace-datasource",
        nargs=2,
        metavar=("OLD_NAME", "NEW_NAME"),
        help="Replace all datasource name references (e.g. bflygz5msh0cga TestData)",
    )
    args = parser.parse_args()

    with open(args.file, "r") as f:
        data = json.load(f)

    data = clean(data, args.replace_datasource)

    with open(args.file, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")

    print(f"✅ Cleaned {args.file}")


if __name__ == "__main__":
    main()
