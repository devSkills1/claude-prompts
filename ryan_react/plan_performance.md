# React 性能优化规划

> 本模板用于分析 React 应用性能问题并给出优化方案

---

## 【使用说明】

**目的：** 输出结构化的性能分析和优化方案，不直接写代码。

**适用场景：**
- 页面加载慢
- 交互卡顿
- 首屏渲染慢
- 包体积过大
- 内存泄漏
- 不必要的重渲染

---

## 【背景】

### 项目基本信息
- **React 版本：** （如 18.2.0）
- **框架：** （CRA / Next.js / Vite / 其他）
- **状态管理：** （Redux / Zustand / Context / 其他）
- **构建工具：** （Webpack / Vite / Turbopack）
- **目标浏览器：** （Chrome/Safari/Firefox 版本要求）

### 性能问题描述
- **问题类型：** （加载慢/卡顿/包体积/内存/其他）
- **出现场景：** （具体页面或操作）
- **复现路径：** （如何稳定复现）
- **影响范围：** （所有用户/特定设备/特定浏览器）

### 性能指标
- **当前表现：**
  - LCP (Largest Contentful Paint)：XXX ms（目标 < 2.5s）
  - FID (First Input Delay)：XXX ms（目标 < 100ms）
  - CLS (Cumulative Layout Shift)：XXX（目标 < 0.1）
  - 包体积：XXX KB
  - 首屏时间：XXX ms

- **目标要求：**
  - Core Web Vitals 全绿
  - 首屏时间 < XXX ms
  - 包体积 < XXX KB

### 约束条件
- **现有依赖：** （已使用的库）
- **技术债务：** （已知问题）
- **资源限制：** （人力/时间）

---

## 【请输出】

### 1. 性能问题诊断

**1.1 加载性能分析**

**Core Web Vitals 检测：**
- LCP 问题：
  - 当前值：XXX ms
  - 问题原因：（大图片/慢API/阻塞资源）
  - 优化空间：

- FID 问题：
  - 当前值：XXX ms
  - 问题原因：（长任务/主线程阻塞）
  - 优化空间：

- CLS 问题：
  - 当前值：XXX
  - 问题原因：（无尺寸图片/动态内容）
  - 优化空间：

**资源加载分析：**
- [ ] JS Bundle 过大（是否 > 200KB）
- [ ] CSS 未拆分
- [ ] 图片未优化
- [ ] 字体加载阻塞
- [ ] 第三方脚本过多

**1.2 渲染性能分析**

**不必要的重渲染：**
```
使用 React DevTools Profiler 分析：
- 组件 A：渲染次数 XX 次/秒
- 组件 B：每次渲染耗时 XX ms
```

**常见问题排查：**
- [ ] 使用内联函数/对象（每次渲染创建新引用）
- [ ] 未使用 React.memo
- [ ] 未使用 useMemo/useCallback
- [ ] Context 更新导致全量重渲染
- [ ] 列表未使用 key 或 key 不稳定

**1.3 包体积分析**

**Bundle 分析：**
```bash
# 使用 webpack-bundle-analyzer 或 vite-plugin-visualizer
npm run build -- --analyze
```

**体积分解：**
- 总体积：XXX KB
- node_modules：XXX KB
- 业务代码：XXX KB
- 最大依赖：XXX（XXX KB）

**优化空间：**
- [ ] 未使用的依赖
- [ ] 重复打包的库
- [ ] 未 Tree Shaking
- [ ] 未代码分割

**1.4 内存泄漏分析**

**常见泄漏场景：**
- [ ] 未清理的 setTimeout/setInterval
- [ ] 未移除的事件监听器
- [ ] 未取消的网络请求
- [ ] 闭包引用导致的泄漏
- [ ] 第三方库泄漏

---

### 2. 优化方案

**2.1 加载优化**

**代码分割（Code Splitting）：**
```typescript
// 路由级别分割
const Dashboard = lazy(() => import('./Dashboard'));

// 组件级别分割
const HeavyChart = lazy(() => import('./HeavyChart'));

// 优化方案：
1. 按路由分割
2. 按功能模块分割
3. 第三方库单独打包
```

**资源优化：**
- **图片优化：**
  - 使用 WebP/AVIF 格式
  - 响应式图片（srcset）
  - 懒加载（Intersection Observer）
  - 图片 CDN

- **字体优化：**
  - font-display: swap
  - 字体子集化
  - 预加载关键字体

- **CSS 优化：**
  - 提取关键 CSS
  - 按路由拆分 CSS
  - 移除未使用的 CSS

**预加载策略：**
```typescript
// 预加载关键资源
<link rel="preload" href="font.woff2" as="font" />

// 预连接第三方域名
<link rel="preconnect" href="https://api.example.com" />

// DNS 预解析
<link rel="dns-prefetch" href="https://cdn.example.com" />
```

**2.2 渲染优化**

**React 优化技巧：**

```typescript
// 1. 使用 React.memo 避免不必要渲染
const ExpensiveComponent = React.memo(({ data }) => {
  return <div>{data}</div>;
});

// 2. 使用 useMemo 缓存计算结果
const sortedData = useMemo(
  () => data.sort((a, b) => a - b),
  [data]
);

// 3. 使用 useCallback 缓存函数
const handleClick = useCallback(() => {
  console.log('clicked');
}, []);

// 4. 虚拟列表（react-window / react-virtualized）
import { FixedSizeList } from 'react-window';

// 5. 组件懒加载
const HeavyComponent = lazy(() => import('./Heavy'));
```

**Context 优化：**
```typescript
// 拆分 Context 避免全量更新
const UserContext = createContext();
const ThemeContext = createContext();

// 使用 Context Selector（use-context-selector）
import { useContextSelector } from 'use-context-selector';
```

**状态管理优化：**
- Redux：使用 Selector 精确订阅
- Zustand：按需订阅 slice
- Jotai：原子化状态

**2.3 包体积优化**

**依赖优化：**
```bash
# 1. 移除未使用的依赖
npm uninstall unused-package

# 2. 使用轻量级替代
# lodash → lodash-es（支持 Tree Shaking）
# moment → dayjs（更小）
# axios → fetch（原生）

# 3. 按需引入
import { debounce } from 'lodash-es';  # ✅
import _ from 'lodash';                # ❌
```

**Tree Shaking：**
```javascript
// package.json
{
  "sideEffects": false  // 启用 Tree Shaking
}
```

**代码压缩：**
- 使用 Terser 压缩 JS
- 使用 cssnano 压缩 CSS
- 开启 Gzip/Brotli 压缩

**2.4 内存优化**

**资源清理：**
```typescript
useEffect(() => {
  const timer = setTimeout(() => {}, 1000);
  const listener = () => {};

  window.addEventListener('resize', listener);

  // 清理函数
  return () => {
    clearTimeout(timer);
    window.removeEventListener('resize', listener);
  };
}, []);
```

**网络请求取消：**
```typescript
useEffect(() => {
  const controller = new AbortController();

  fetch('/api/data', { signal: controller.signal })
    .then(res => res.json())
    .catch(err => {
      if (err.name !== 'AbortError') {
        console.error(err);
      }
    });

  return () => controller.abort();
}, []);
```

---

### 3. 监控和工具

**性能分析工具：**
- Chrome DevTools (Performance/Lighthouse)
- React DevTools (Profiler)
- webpack-bundle-analyzer
- Lighthouse CI

**监控指标：**
- Core Web Vitals（LCP/FID/CLS）
- 自定义性能指标
- 错误监控
- 用户行为追踪

**持续监控方案：**
```typescript
// Web Vitals 监控
import { getCLS, getFID, getLCP } from 'web-vitals';

getCLS(console.log);
getFID(console.log);
getLCP(console.log);
```

---

### 4. 优先级排序

**P0 - 必须立即解决：**
1. 问题：首屏加载时间 > 5s
   - 影响：用户流失率高
   - 方案：代码分割 + 资源优化
   - 预期收益：首屏时间降低 60%

**P1 - 重要但不紧急：**
1. 问题：包体积过大（> 500KB）
   - 影响：移动端体验差
   - 方案：依赖优化 + Tree Shaking
   - 预期收益：体积减小 40%

**P2 - 优化项：**
1. 问题：列表滚动卡顿
   - 影响：用户体验
   - 方案：虚拟列表
   - 预期收益：FPS 60+

---

### 5. 实施计划

**阶段 1：性能分析（3 天）**
- [ ] Lighthouse 审计
- [ ] Bundle 分析
- [ ] Profiler 分析
- [ ] 确认优化方向

**阶段 2：优化实施（2 周）**
- [ ] P0 问题修复
- [ ] P1 问题优化
- [ ] P2 优化项

**阶段 3：验证监控（3 天）**
- [ ] Lighthouse 对比
- [ ] 真实用户监控
- [ ] 灰度验证

---

### 6. 效果评估

**量化指标：**
| 指标 | 优化前 | 优化后 | 提升 |
|------|--------|--------|------|
| LCP | 4.5s | 2.0s | 55% ↓ |
| FID | 200ms | 80ms | 60% ↓ |
| 包体积 | 800KB | 400KB | 50% ↓ |
| 首屏时间 | 5s | 2s | 60% ↓ |

**用户体验：**
- 跳出率降低
- 转化率提升
- 用户满意度提升

---

### 7. 最佳实践

**开发规范：**
1. 避免内联函数/对象
2. 合理使用 memo/useMemo/useCallback
3. 列表必须使用稳定的 key
4. 大组件必须代码分割

**Code Review 检查点：**
- [ ] 是否有性能隐患
- [ ] 是否正确清理资源
- [ ] 是否使用性能最佳实践
- [ ] 包体积是否增长

---

## 【输出要求】

1. **数据支撑：** 使用 Lighthouse/Profiler 等工具获取真实数据
2. **具体方案：** 每个优化项都要有具体实施方案
3. **量化目标：** 明确优化前后的量化指标
4. **风险控制：** 评估优化风险和应对措施

---

## 【注意事项】

⚠️ **本模板仅做分析规划，不直接生成代码**

✅ **后续步骤：**
1. 使用 Lighthouse 分析性能
2. 将输出作为优化方案文档
3. 使用 `code_execute_step.md` 逐步优化
4. 使用 `checklist.md` 验证优化效果
5. 持续监控性能指标
