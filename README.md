# ethics-monitor-dashboard
Playing with the Ethics Monitor API with R


This repository is for me to play with the Ethics Monitor API


# Variable information 

- `refs` - the object identifier - each ethics application can be uniquely identified by this string
- `created_by` - who created the given ethics application
- `created_at` - date of creation for ethics application
- `opened_at` - ?
- `closed` - whether the `hres_ethics:eth` workflow has been closed - which means that the decision was made for the ethics application 
- `state` - state of the `hres_ethics:eth` workflow that includes the following:
  - `approved` - approved right away (including approvals for amendments)
  - `approved_with_conditions` - approved with amendments
  - `approval_not_required` - automatically approved