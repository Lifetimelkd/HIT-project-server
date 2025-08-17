package org.dromara.hit.project.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 趋势数据VO
 *
 * @author HIT-project-team
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TrendDataVo {
    private String date;
    private Long count;
}
