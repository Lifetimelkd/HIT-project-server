package org.dromara.hit.project.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 类型分布数据VO
 *
 * @author HIT-project-team
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TypeDistributionVo {
    private String type;
    private String typeName;
    private Long count;
}
