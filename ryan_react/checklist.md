# React 开发审计检查清单

> 发布前/Code Review 时的完整检查清单

---

## 使用说明

**用途：** 在以下场景使用此清单
- 重要功能发布前
- Code Review 时
- 性能优化后验证
- 定期代码审计

**使用方式：**
1. 逐项检查，标记 `[x]` 表示通过
2. 发现问题记录并修复
3. 全部通过后方可发布

---

## 1. 性能检查

### 1.1 Core Web Vitals

**P0 - 必须检查：**
- [ ] LCP < 2.5s（Largest Contentful Paint）
- [ ] INP < 200ms（Interaction to Next Paint）
- [ ] CLS < 0.1（Cumulative Layout Shift）
- [ ] 使用 Lighthouse 测试分数 > 90

**检查工具：**
- Chrome DevTools - Lighthouse
- PageSpeed Insights
- Web Vitals 扩展

---

### 1.2 渲染性能

**P0 - 必须检查：**
- [ ] 无明显的渲染卡顿（60fps）
- [ ] 列表滚动流畅
- [ ] 动画流畅（使用 CSS transform/opacity）
- [ ] 无不必要的重渲染（使用 React DevTools Profiler）

**P1 - 建议检查：**
- [ ] 长列表使用虚拟列表（react-window）
- [ ] 图片懒加载
- [ ] 组件懒加载（React.lazy）
- [ ] 使用 React.memo 优化子组件

**检查工具：**
- React DevTools - Profiler
- Chrome DevTools - Performance

---

### 1.3 包体积

**P0 - 必须检查：**
- [ ] 初始 JS Bundle < 200KB（gzip 后）
- [ ] 总 JS Bundle < 500KB（gzip 后）
- [ ] 是否使用代码分割（路由级别）
- [ ] 是否移除未使用的依赖

**P1 - 建议检查：**
- [ ] 使用 Tree Shaking
- [ ] 大型依赖按需引入
- [ ] 图片使用 WebP/AVIF 格式
- [ ] 使用 Bundle Analyzer 分析体积

**检查工具：**
```bash
# Webpack
npm run build -- --analyze

# Vite
vite-bundle-visualizer
```

---

### 1.4 加载性能

**P0 - 必须检查：**
- [ ] 首屏时间 < 3s（3G 网络）
- [ ] 关键资源预加载（preload）
- [ ] 第三方脚本异步加载
- [ ] 字体使用 font-display: swap

**P1 - 建议检查：**
- [ ] 使用 HTTP/2 或 HTTP/3
- [ ] 开启 Gzip/Brotli 压缩
- [ ] 静态资源使用 CDN
- [ ] 实现 Service Worker 缓存

---

## 2. 代码质量

### 2.1 React 最佳实践

**P0 - 必须检查：**
- [ ] 组件职责单一（< 200 行）
- [ ] 无直接修改 state
- [ ] 正确使用 useEffect 依赖数组
- [ ] key 稳定且唯一（列表渲染）
- [ ] 避免内联函数/对象（性能敏感场景）

**P1 - 建议检查：**
- [ ] 使用 TypeScript 类型检查
- [ ] 组件有 PropTypes 或 TypeScript 类型
- [ ] 复杂逻辑抽取为自定义 Hooks
- [ ] 使用 ESLint 规则检查

---

### 2.2 Hooks 使用

**P0 - 必须检查：**
- [ ] 遵循 Hooks 规则（不在条件/循环中调用）
- [ ] useEffect 正确清理副作用
- [ ] useCallback/useMemo 依赖正确
- [ ] 避免过度使用 useMemo/useCallback

**P1 - 建议检查：**
- [ ] 自定义 Hooks 命名以 use 开头
- [ ] 相关逻辑封装为自定义 Hooks
- [ ] 使用 eslint-plugin-react-hooks 检查

---

### 2.3 状态管理

**P0 - 必须检查：**
- [ ] 状态放置合理（本地 vs 全局）
- [ ] 避免 prop drilling（超过 3 层考虑 Context/状态管理）
- [ ] 状态更新遵循不可变原则
- [ ] 异步状态正确处理（loading/error）

**P1 - 建议检查：**
- [ ] 使用状态管理库（Redux/Zustand/Jotai）
- [ ] Context 拆分避免全量更新
- [ ] 状态持久化（localStorage/IndexedDB）

---

### 2.4 API 使用规范

**P0 - 必须检查：**
- [ ] **是否使用已废弃 (deprecated) 的 React API**
  - 检查编译警告和 React DevTools 警告
  - 必须替换为官方推荐的新 API
  - 使用 ESLint 规则 `react/no-deprecated` 检测
- [ ] 是否使用了不推荐的生命周期方法
- [ ] 第三方包是否与当前 React 版本兼容

**P1 - 建议检查：**
- [ ] 是否有更现代的替代方案（如 React 19 新特性）
- [ ] 是否遵循最新的 React 最佳实践

**常见废弃 API 替换示例：**

```tsx
// ⚠️ 注意：@types/react@18 移除了 React.FC 的隐式 children
// 如果组件需要 children，必须显式声明

// 方式一：在 Props 中显式声明 children
interface Props {
  title: string;
  children: React.ReactNode;
}
const MyComponent: React.FC<Props> = ({ title, children }) => { }

// 方式二：使用 PropsWithChildren
const MyComponent: React.FC<PropsWithChildren<Props>> = ({ children }) => { }

// 方式三：直接类型标注（无需 React.FC）
const MyComponent = ({ children }: Props & { children?: ReactNode }) => { }

// ❌ 废弃：componentWillMount / componentWillReceiveProps / componentWillUpdate
class MyComponent extends React.Component {
  componentWillMount() { }  // 已废弃
}

// ✅ 推荐：使用 Hooks
function MyComponent() {
  useEffect(() => {
    // 替代 componentDidMount
  }, []);
}

// ❌ 废弃：ReactDOM.render (React 18+)
ReactDOM.render(<App />, document.getElementById('root'));

// ✅ 推荐：createRoot
import { createRoot } from 'react-dom/client';
const root = createRoot(document.getElementById('root')!);
root.render(<App />);

// ❌ 废弃：findDOMNode
const node = ReactDOM.findDOMNode(this);

// ✅ 推荐：使用 ref
const ref = useRef<HTMLDivElement>(null);
<div ref={ref} />
```

**React 版本兼容性对照表：**

| API | 废弃版本 | 移除版本 | 替代方案 |
|-----|---------|---------|---------|
| React.FC 隐式 children | @types/react@18 | - | 显式声明 children 类型 |
| componentWillMount | React 16.3 | React 19 | useEffect(() => {}, []) |
| componentWillReceiveProps | React 16.3 | React 19 | useEffect(() => {}, [props]) |
| componentWillUpdate | React 16.3 | React 19 | useEffect(() => {}) / getSnapshotBeforeUpdate |
| ReactDOM.render | React 18.0 | React 19 | createRoot(el).render() |
| ReactDOM.hydrate | React 18.0 | React 19 | hydrateRoot() |
| findDOMNode | React 16.6 | React 19 | useRef() |
| Legacy Context (contextTypes) | React 16.6 | React 19 | createContext() |
| String refs | React 16.3 | React 19 | useRef() / callback refs |
| defaultProps (函数组件) | React 15.5 | React 19 | ES6 默认参数 |
| propTypes | React 15.5 | React 19 | TypeScript / 运行时验证库 |
| React.createFactory | React 16.13 | React 19 | JSX |

**React 19 新特性：**
- ✅ Actions (`useActionState`, `useFormStatus`, `useFormState`)
- ✅ `use()` Hook（读取 Promise/Context）
- ✅ `ref` 作为 props（无需 `forwardRef`，未来版本将废弃 forwardRef）
- ✅ `useOptimistic` Hook
- ✅ React Compiler（自动 memo，需单独安装）
- ✅ Document Metadata（原生 `<title>`, `<meta>` 支持）
- ✅ 资源预加载 API（`preload()`, `preinit()`）

**React 19.2 新特性（2025.10）：**
- ✅ `<Activity>` 组件（UI 活动状态管理）
- ✅ `useEffectEvent` Hook（Effect 中的稳定事件回调）
- ✅ `cacheSignal`（RSC 缓存信号）

---

## 3. 无障碍（Accessibility）

### 3.1 WCAG 2.1 AA 标准

**P0 - 必须检查：**
- [ ] 所有图片有 alt 文本
- [ ] 表单有 label 或 aria-label
- [ ] 按钮/链接有描述性文本
- [ ] 键盘可操作（Tab/Enter/Esc）
- [ ] Focus 状态可见

**P1 - 建议检查：**
- [ ] 使用语义化 HTML 标签
- [ ] ARIA 属性正确使用
- [ ] 对比度符合要求（≥ 4.5:1）
- [ ] 屏幕阅读器测试（NVDA/JAWS）

**检查工具：**
- axe DevTools
- Lighthouse Accessibility Audit
- WAVE Extension

---

### 3.2 键盘导航

**P0 - 必须检查：**
- [ ] 所有交互元素可 Tab 访问
- [ ] Tab 顺序符合逻辑
- [ ] 模态框打开时 focus 管理正确
- [ ] Esc 键关闭模态框/下拉菜单

---

## 4. SEO 优化

### 4.1 基础 SEO

**P0 - 必须检查：**
- [ ] 每个页面有唯一的 title
- [ ] 每个页面有 meta description
- [ ] 使用语义化 HTML（h1-h6/article/nav）
- [ ] 图片有 alt 文本
- [ ] URL 结构清晰

**P1 - 建议检查：**
- [ ] 实现 SSR/SSG（Next.js/Remix）
- [ ] 结构化数据（JSON-LD）
- [ ] Open Graph 标签（社交分享）
- [ ] Sitemap 和 robots.txt

**检查工具：**
- Google Search Console
- Lighthouse SEO Audit

---

## 5. 安全检查

### 5.1 常见漏洞

**P0 - 必须检查：**
- [ ] 无 XSS 漏洞（使用 dangerouslySetInnerHTML 需审查）
- [ ] 无 CSRF 漏洞（表单使用 CSRF token）
- [ ] API Key 不在代码中硬编码
- [ ] 敏感数据不在 localStorage（使用 httpOnly cookie）
- [ ] 用户输入正确验证和清理

**P1 - 建议检查：**
- [ ] 使用 Content Security Policy (CSP)
- [ ] HTTPS 强制使用
- [ ] 依赖包无已知漏洞（npm audit）
- [ ] 实现 Rate Limiting

**检查工具：**
```bash
# 检查依赖漏洞
npm audit
# 或
yarn audit
```

---

### 5.2 数据保护

**P0 - 必须检查：**
- [ ] 敏感数据加密传输（HTTPS）
- [ ] 密码不在客户端明文存储
- [ ] Token 有过期时间
- [ ] 实现用户登出功能

---

## 6. 浏览器兼容性

**P0 - 必须检查：**
- [ ] 在目标浏览器测试（Chrome/Safari/Firefox）
- [ ] 移动端浏览器测试（iOS Safari/Chrome）
- [ ] 响应式布局正常
- [ ] Polyfill 必要的 API

**P1 - 建议检查：**
- [ ] 使用 Browserslist 配置目标浏览器
- [ ] 使用 @babel/preset-env 自动 polyfill
- [ ] 在 BrowserStack/Sauce Labs 测试

**工具：**
```json
// browserslist in package.json
{
  "browserslist": [
    ">0.2%",
    "not dead",
    "not op_mini all"
  ]
}
```

---

## 7. 错误处理

### 7.1 错误边界

**P0 - 必须检查：**
- [ ] 实现 Error Boundary 组件
- [ ] 关键组件使用 Error Boundary 包裹
- [ ] 错误信息友好展示
- [ ] 错误日志记录（Sentry/LogRocket）

```tsx
class ErrorBoundary extends React.Component {
  state = { hasError: false };

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    // 记录错误到监控服务
    console.error('Error caught:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <ErrorFallback />;
    }
    return this.props.children;
  }
}
```

---

### 7.2 异步错误处理

**P0 - 必须检查：**
- [ ] 网络请求有错误处理
- [ ] 显示错误状态给用户
- [ ] 实现错误重试机制
- [ ] Promise rejection 有 catch

---

## 8. 测试覆盖

**P0 - 必须检查：**
- [ ] 核心功能有单元测试
- [ ] 关键用户流程有集成测试

**P1 - 建议检查：**
- [ ] 组件测试覆盖率 > 70%
- [ ] 使用 React Testing Library
- [ ] E2E 测试（Playwright/Cypress）
- [ ] 视觉回归测试

---

## 9. 用户体验

**P0 - 必须检查：**
- [ ] 加载状态明确展示（Loading/Skeleton）
- [ ] 错误信息友好易懂
- [ ] 表单验证实时反馈
- [ ] 按钮点击有视觉反馈

**P1 - 建议检查：**
- [ ] 空状态有提示
- [ ] 长操作有进度条
- [ ] 实现乐观更新（Optimistic UI）
- [ ] 过渡动画流畅

---

## 10. 发布准备

**P0 - 必须检查：**
- [ ] 版本号更新（package.json）
- [ ] CHANGELOG 更新
- [ ] 移除 console.log
- [ ] 移除调试代码
- [ ] 使用生产模式构建（NODE_ENV=production）
- [ ] 环境变量配置正确

**P1 - 建议检查：**
- [ ] 配置错误监控（Sentry）
- [ ] 配置性能监控（Web Vitals）
- [ ] 准备回滚方案
- [ ] 灰度发布计划

---

## 审计结论模板

**审计时间：** YYYY-MM-DD

**审计范围：** （功能模块/页面）

**检查结果：**
- ✅ 通过项：XX 项
- ⚠️ 警告项：XX 项（需优化但不阻塞发布）
- ❌ 阻断项：XX 项（必须修复）

**Core Web Vitals：**
| 指标 | 值 | 状态 |
|------|-----|------|
| LCP | X.Xs | ✅/❌ |
| INP | XXms | ✅/❌ |
| CLS | X.XX | ✅/❌ |

**阻断问题：**
1. 问题描述
   - 严重程度：P0
   - 修复方案：
   - 预计修复时间：

**结论：** ✅ 可发布 / ❌ 需修复后再发布

**审计人：** XXX
