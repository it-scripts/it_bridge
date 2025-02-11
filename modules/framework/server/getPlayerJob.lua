function it.getPlayerJob(player)

    if not player then
        lib.print.error('[getPlayerJob] No player object found')
        return nil
    end

    if it.framework == Framework.ESX then
        local job = player.getJob()
        if job then
            return {
                name = job.name,
                label = job.label,
                grade = job.grade,
                grade_label = job.grade_label,
                grade_salary = job.grade_salary,
                isBoss = job.grade_name == 'boss' or false,
                onDuty = true
            }
        end
    end

    if it.framework == Framework.QBCore then
        local jobInfo = player.PlayerData.job
        if jobInfo then
            return {
                name = jobInfo.name,
                label = jobInfo.label,
                grade = jobInfo.grade.level,
                grade_label = jobInfo.grade.name,
                grade_salary = jobInfo.payment,
                isBoss = jobInfo.isBoss,
                onDuty = jobInfo.onduty
            }
        end
    end

    if it.framework == Framework.QBOX then
        local job = player.PlayerData.job
        if job then
            return {
                name = job.name,
                label = job.label,
                grade = job.grade.level,
                grade_label = job.grade.name,
                grade_salary = job.payment,
                isBoss = job.isBoss,
                onDuty = job.onduty
            }
        end
    end

    if it.framework == Framework.NDCore then
        local job = player.job
        local jobInfo = player.jobInfo

        if job and jobInfo then
            return {
                name = job,
                label = jobInfo.label,
                grade = jobInfo.grade.rank,
                grade_label = jobInfo.grade.name,
                grade_salary = 0,
                isBoss = jobInfo.rankName == 'boss' or false,
                onDuty = true
            }
        end
    end

    lib.print.error('[getPlayerJob] Failed to get player job')
    return nil
end

return it.getPlayerJob