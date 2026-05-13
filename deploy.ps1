# ============================================================
#  brand-ltv-dashboard 배포 스크립트
#  사용법: 이 파일을 PowerShell로 실행 (우클릭 → PS로 실행)
#  결과: https://mineuihong-afk.github.io/brand-ltv-dashboard/
# ============================================================

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $repoDir

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Brand LTV Dashboard 배포 시작" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 변경 파일 확인
$status = git status --short
if (-not $status) {
    Write-Host "⚠️  변경된 파일이 없습니다." -ForegroundColor Yellow
    Write-Host "   수정 후 다시 실행해주세요." -ForegroundColor Yellow
    Read-Host "`n아무 키나 누르면 종료"
    exit
}

Write-Host "📄 변경된 파일:" -ForegroundColor White
git status --short
Write-Host ""

# 커밋 메시지 입력
$msg = Read-Host "커밋 메시지 입력 (Enter = 'update dashboard')"
if (-not $msg) { $msg = "update dashboard" }

Write-Host ""

# add → commit → push
git add -A
git commit -m $msg
$pushResult = git push 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✅ 배포 완료!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  🔗 전체 브랜드 대시보드" -ForegroundColor White
    Write-Host "     https://mineuihong-afk.github.io/brand-ltv-dashboard/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  🟢 스타벅스 분석 페이지" -ForegroundColor White
    Write-Host "     https://mineuihong-afk.github.io/brand-ltv-dashboard/starbucks.html" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  ※ GitHub Pages 반영까지 1~2분 소요" -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "❌ 배포 실패. 아래 오류를 확인하세요:" -ForegroundColor Red
    Write-Host $pushResult -ForegroundColor Red
}

Write-Host ""
Read-Host "아무 키나 누르면 종료"
