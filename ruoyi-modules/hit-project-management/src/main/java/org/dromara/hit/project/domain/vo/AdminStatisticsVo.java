package org.dromara.hit.project.domain.vo;

import lombok.Data;

/**
 * 管理后台统计数据VO
 *
 * @author HIT-project-team
 */
@Data
public class AdminStatisticsVo {
    private Long totalProjects;
    private Long activeProjects;
    private Long completedProjects;
    private Long pendingApplications;
    private Long totalMembers;
    private Long activeMembers;
    private Long projectsIncrease;
    private Long membersIncrease;
    private Long totalApplications;
    private Long approvedApplications;
    private Long rejectedApplications;
}
