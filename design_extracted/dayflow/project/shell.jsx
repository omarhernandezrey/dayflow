// shell.jsx — Shared dark theme tokens, bottom nav, icons, and small UI atoms
// for the DayFlow app. All screens import these via window.

// ─────────────────────────────────────────────────────────────
// Dark theme tokens
// ─────────────────────────────────────────────────────────────
const T = {
  bg: '#0E0F13',
  surface: '#181A20',
  surface2: '#1F222A',
  surfaceHi: '#262A33',
  border: 'rgba(255,255,255,0.07)',
  borderStrong: 'rgba(255,255,255,0.12)',
  text: '#F2F3F7',
  textDim: '#A4A8B3',
  textMute: '#6B6F7A',

  // Primary brand (DayFlow blue)
  blue: '#3D7BFF',
  blueSoft: 'rgba(61,123,255,0.15)',
  blueDeep: '#2A5BC8',

  // Categories (matching screenshots)
  academic: '#3D7BFF',  // blue
  health:   '#22C55E',  // green
  personal: '#F59E0B',  // amber

  // Status
  success: '#22C55E',
  warning: '#F59E0B',
  danger:  '#EF4444',

  // Type
  font: '-apple-system, "SF Pro Display", "SF Pro Text", Inter, system-ui, sans-serif',
};

// ─────────────────────────────────────────────────────────────
// Icons (24px stroke=1.8, currentColor)
// ─────────────────────────────────────────────────────────────
const Icon = ({ name, size = 22, color = 'currentColor', strokeWidth = 1.8 }) => {
  const p = { width: size, height: size, viewBox: '0 0 24 24', fill: 'none',
              stroke: color, strokeWidth, strokeLinecap: 'round', strokeLinejoin: 'round' };
  switch (name) {
    case 'home':
      return <svg {...p}><path d="M3 11l9-7 9 7"/><path d="M5 10v10h14V10"/></svg>;
    case 'home-fill':
      return <svg {...p} fill={color} stroke="none"><path d="M11.3 3.2a1 1 0 011.4 0l8.6 7.6a.5.5 0 01-.3.9H20v8.8a.5.5 0 01-.5.5H15v-6.5a3 3 0 00-6 0V21H4.5a.5.5 0 01-.5-.5V11.7H2.7a.5.5 0 01-.3-.9l8.9-7.6z"/></svg>;
    case 'tasks':
      return <svg {...p}><rect x="4" y="4" width="16" height="16" rx="3"/><path d="M8 10l3 3 5-6"/></svg>;
    case 'tasks-fill':
      return <svg {...p}><rect x="3.5" y="3.5" width="17" height="17" rx="3.5" fill={color} stroke="none"/><path d="M8 12.2l2.8 2.8 5.2-6" stroke="#0E0F13" strokeWidth="2.2"/></svg>;
    case 'habits':
      return <svg {...p}><path d="M20.8 12a8.8 8.8 0 11-17.6 0 8.8 8.8 0 0117.6 0z"/><path d="M8.5 12l2.5 2.5 4.5-5"/></svg>;
    case 'habits-fill':
      return <svg {...p}><circle cx="12" cy="12" r="9" fill={color} stroke="none"/><path d="M8 12l2.8 2.8L16 9.5" stroke="#0E0F13" strokeWidth="2.2"/></svg>;
    case 'stats':
      return <svg {...p}><path d="M5 20V11"/><path d="M12 20V4"/><path d="M19 20v-6"/></svg>;
    case 'stats-fill':
      return <svg {...p} stroke="none" fill={color}><rect x="3.5" y="11" width="3.5" height="9" rx="1.2"/><rect x="10.25" y="4" width="3.5" height="16" rx="1.2"/><rect x="17" y="14" width="3.5" height="6" rx="1.2"/></svg>;
    case 'more':
      return <svg {...p}><circle cx="5" cy="12" r="1.2" fill={color}/><circle cx="12" cy="12" r="1.2" fill={color}/><circle cx="19" cy="12" r="1.2" fill={color}/></svg>;
    case 'bell':
      return <svg {...p}><path d="M6 8a6 6 0 1112 0c0 5 2 6 2 6H4s2-1 2-6"/><path d="M10 19a2 2 0 004 0"/></svg>;
    case 'menu':
      return <svg {...p}><path d="M4 7h16M4 12h16M4 17h10"/></svg>;
    case 'plus':
      return <svg {...p}><path d="M12 5v14M5 12h14"/></svg>;
    case 'chevron-left':
      return <svg {...p}><path d="M14 6l-6 6 6 6"/></svg>;
    case 'chevron-right':
      return <svg {...p}><path d="M10 6l6 6-6 6"/></svg>;
    case 'chevron-down':
      return <svg {...p}><path d="M6 9l6 6 6-6"/></svg>;
    case 'check':
      return <svg {...p}><path d="M5 12l5 5 9-11"/></svg>;
    case 'check-circle-fill':
      return <svg {...p}><circle cx="12" cy="12" r="9.5" fill={color} stroke="none"/><path d="M8 12.5l2.8 2.8 5-6" stroke="#0E0F13" strokeWidth="2.2"/></svg>;
    case 'circle':
      return <svg {...p}><circle cx="12" cy="12" r="9"/></svg>;
    case 'clock':
      return <svg {...p}><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>;
    case 'calendar':
      return <svg {...p}><rect x="3.5" y="5" width="17" height="15" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/></svg>;
    case 'flame':
      return <svg {...p} fill={color} stroke="none"><path d="M12 2.5c.6 3 2.6 4.4 4 6.2 1.6 2 2.5 3.8 2.5 6 0 3.6-3 6.8-6.5 6.8S5.5 18.3 5.5 14.7c0-2 1-3.4 2-4.4.5.7 1.3 1.4 2 1.4 0-3.4 1-6.4 2.5-9.2z"/><path d="M12 13c-.8 1-1.5 2-1.5 3.4 0 1.5 1 2.6 1.5 2.6s1.5-1.1 1.5-2.6c0-1.4-.7-2.4-1.5-3.4z" fill="#FFD89B"/></svg>;
    case 'settings':
      return <svg {...p}><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.7 1.7 0 00.3 1.9l.1.1a2 2 0 11-2.8 2.8l-.1-.1a1.7 1.7 0 00-1.9-.3 1.7 1.7 0 00-1 1.5V21a2 2 0 11-4 0v-.1a1.7 1.7 0 00-1.1-1.5 1.7 1.7 0 00-1.9.3l-.1.1a2 2 0 11-2.8-2.8l.1-.1a1.7 1.7 0 00.3-1.9 1.7 1.7 0 00-1.5-1H3a2 2 0 110-4h.1A1.7 1.7 0 004.6 9a1.7 1.7 0 00-.3-1.9l-.1-.1a2 2 0 112.8-2.8l.1.1a1.7 1.7 0 001.9.3H9a1.7 1.7 0 001-1.5V3a2 2 0 114 0v.1a1.7 1.7 0 001 1.5 1.7 1.7 0 001.9-.3l.1-.1a2 2 0 112.8 2.8l-.1.1a1.7 1.7 0 00-.3 1.9V9a1.7 1.7 0 001.5 1H21a2 2 0 110 4h-.1a1.7 1.7 0 00-1.5 1z"/></svg>;
    case 'user':
      return <svg {...p}><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>;
    case 'trophy':
      return <svg {...p}><path d="M7 4h10v4a5 5 0 11-10 0V4z"/><path d="M7 6H4v2a3 3 0 003 3M17 6h3v2a3 3 0 01-3 3M9 17h6l-1 4h-4l-1-4z"/></svg>;
    case 'trash':
      return <svg {...p}><path d="M4 7h16M9 7V5a2 2 0 012-2h2a2 2 0 012 2v2M6 7l1 13a2 2 0 002 2h6a2 2 0 002-2l1-13"/></svg>;
    case 'edit':
      return <svg {...p}><path d="M4 20h4l11-11-4-4L4 16v4z"/><path d="M14 6l4 4"/></svg>;
    case 'tag':
      return <svg {...p}><path d="M3 12V4a1 1 0 011-1h8l9 9-9 9-9-9z"/><circle cx="8" cy="8" r="1.4" fill={color}/></svg>;
    case 'repeat':
      return <svg {...p}><path d="M17 2l4 4-4 4"/><path d="M3 12V8a2 2 0 012-2h16M7 22l-4-4 4-4"/><path d="M21 12v4a2 2 0 01-2 2H3"/></svg>;
    case 'water':
      return <svg {...p} fill={color} stroke="none"><path d="M12 2.5c4 4.5 7 8 7 11.5a7 7 0 11-14 0c0-3.5 3-7 7-11.5z"/></svg>;
    case 'dumbbell':
      return <svg {...p}><path d="M2 9v6M5 6v12M8 8v8M16 8v8M19 6v12M22 9v6"/><path d="M8 12h8"/></svg>;
    case 'leaf':
      return <svg {...p}><path d="M5 19c0-8 6-14 14-14 0 8-5 14-14 14z"/><path d="M5 19l8-8"/></svg>;
    case 'moon':
      return <svg {...p}><path d="M20 14.5A8 8 0 119.5 4a6.5 6.5 0 0010.5 10.5z"/></svg>;
    case 'sparkle':
      return <svg {...p}><path d="M12 3v4M12 17v4M3 12h4M17 12h4M6 6l2.5 2.5M15.5 15.5L18 18M6 18l2.5-2.5M15.5 8.5L18 6"/></svg>;
    case 'logout':
      return <svg {...p}><path d="M14 8V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2h7a2 2 0 002-2v-2"/><path d="M17 8l4 4-4 4M10 12h11"/></svg>;
    case 'palette':
      return <svg {...p}><path d="M12 3a9 9 0 100 18c1 0 1.5-.5 1.5-1.5 0-.5-.2-1-.5-1.3-.3-.4-.5-.8-.5-1.2 0-1 .8-1.8 1.8-1.8H17a4 4 0 004-4c0-4.5-4-8.2-9-8.2z"/><circle cx="7" cy="10" r="1" fill={color}/><circle cx="11" cy="7" r="1" fill={color}/><circle cx="16" cy="9" r="1" fill={color}/><circle cx="17" cy="13" r="1" fill={color}/></svg>;
    case 'shield':
      return <svg {...p}><path d="M12 3l8 3v6c0 5-4 8.5-8 9-4-.5-8-4-8-9V6l8-3z"/></svg>;
    case 'help':
      return <svg {...p}><circle cx="12" cy="12" r="9"/><path d="M9.5 9.5a2.5 2.5 0 015 0c0 1.5-2.5 2-2.5 4M12 17.5h.01"/></svg>;
    case 'book':
      return <svg {...p}><path d="M4 5a2 2 0 012-2h13v16H6a2 2 0 00-2 2V5z"/><path d="M4 19a2 2 0 012-2h13"/></svg>;
    case 'briefcase':
      return <svg {...p}><rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2M3 13h18"/></svg>;
    case 'cart':
      return <svg {...p}><circle cx="9" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/><path d="M3 3h2l3 13h11l2-8H6"/></svg>;
    case 'stethoscope':
      return <svg {...p}><path d="M5 3v6a4 4 0 008 0V3"/><path d="M5 3h2M11 3h2"/><path d="M9 13v3a4 4 0 008 0v-1"/><circle cx="17" cy="14" r="2"/></svg>;
    default:
      return null;
  }
};

// ─────────────────────────────────────────────────────────────
// Bottom nav (5 tabs: Inicio, Tareas, Hábitos, Estadísticas, Más)
// ─────────────────────────────────────────────────────────────
function BottomNav({ active = 'home' }) {
  const tabs = [
    { id: 'home',   label: 'Inicio',        icon: 'home',   activeIcon: 'home-fill'   },
    { id: 'tasks',  label: 'Tareas',        icon: 'tasks',  activeIcon: 'tasks-fill'  },
    { id: 'habits', label: 'Hábitos',       icon: 'habits', activeIcon: 'habits-fill' },
    { id: 'stats',  label: 'Estadísticas',  icon: 'stats',  activeIcon: 'stats-fill'  },
    { id: 'more',   label: 'Más',           icon: 'more',   activeIcon: 'more'        },
  ];
  return (
    <div style={{
      position: 'absolute', bottom: 0, left: 0, right: 0,
      paddingTop: 10, paddingBottom: 34,
      background: 'rgba(14,15,19,0.92)',
      backdropFilter: 'blur(20px) saturate(180%)',
      WebkitBackdropFilter: 'blur(20px) saturate(180%)',
      borderTop: `1px solid ${T.border}`,
      display: 'flex', justifyContent: 'space-around', alignItems: 'flex-end',
      zIndex: 40,
    }}>
      {tabs.map(t => {
        const isActive = t.id === active;
        return (
          <div key={t.id} style={{
            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 4,
            flex: 1, minWidth: 0,
          }}>
            <Icon name={isActive ? t.activeIcon : t.icon} size={24}
                  color={isActive ? T.blue : T.textMute}
                  strokeWidth={isActive ? 2 : 1.8} />
            <div style={{
              fontFamily: T.font, fontSize: 10.5, fontWeight: isActive ? 600 : 500,
              color: isActive ? T.blue : T.textMute, letterSpacing: -0.1,
              whiteSpace: 'nowrap',
            }}>{t.label}</div>
          </div>
        );
      })}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Top app bar — burger / title / action (matches captures)
// ─────────────────────────────────────────────────────────────
function AppBar({ left = 'menu', leftAction, title, right = 'bell', rightAction, transparent = false }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '0 16px', height: 56, marginTop: 8,
      background: transparent ? 'transparent' : T.bg,
      position: 'relative', zIndex: 5,
    }}>
      <button onClick={leftAction} style={{
        width: 40, height: 40, borderRadius: 12, border: 'none',
        background: 'transparent', color: T.text, cursor: 'pointer',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
      }}>
        {left && <Icon name={left} size={22} />}
      </button>
      <div style={{
        fontFamily: T.font, fontSize: 18, fontWeight: 600, color: T.text,
        letterSpacing: -0.2,
      }}>{title}</div>
      <button onClick={rightAction} style={{
        width: 40, height: 40, borderRadius: 12, border: 'none',
        background: 'transparent', color: T.text, cursor: 'pointer',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        position: 'relative',
      }}>
        {right && <Icon name={right} size={22} />}
        {right === 'bell' && (
          <div style={{
            position: 'absolute', top: 9, right: 11, width: 8, height: 8,
            borderRadius: 4, background: T.danger,
            border: `2px solid ${T.bg}`,
          }} />
        )}
      </button>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Phone shell — places content over the iOS device chrome, leaves room
// for status bar (top) and nav + home indicator (bottom).
// ─────────────────────────────────────────────────────────────
function PhoneShell({ children, activeTab, hideNav = false }) {
  return (
    <IOSDevice width={360} height={780} dark={true}>
      <div style={{
        position: 'absolute', inset: 0,
        paddingTop: 54,  // status bar
        paddingBottom: hideNav ? 0 : 84, // bottom nav + home indicator
        display: 'flex', flexDirection: 'column',
        background: T.bg,
        overflow: 'hidden',
      }}>
        <div style={{ flex: 1, overflow: 'auto', position: 'relative' }}>
          {children}
        </div>
        {!hideNav && <BottomNav active={activeTab} />}
      </div>
    </IOSDevice>
  );
}

// ─────────────────────────────────────────────────────────────
// Atoms used across screens
// ─────────────────────────────────────────────────────────────
function CategoryDot({ category, size = 10 }) {
  const c = { academic: T.academic, health: T.health, personal: T.personal }[category] || T.textDim;
  return <div style={{ width: size, height: size, borderRadius: size/2, background: c, flexShrink: 0 }} />;
}

function CategoryPill({ category, size = 'sm' }) {
  const map = {
    academic: { c: T.academic, label: 'Académica' },
    health:   { c: T.health,   label: 'Salud'     },
    personal: { c: T.personal, label: 'Personal'  },
  };
  const m = map[category] || { c: T.textDim, label: '—' };
  const pad = size === 'sm' ? '3px 9px' : '6px 12px';
  const fs = size === 'sm' ? 11 : 12.5;
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center', gap: 6,
      padding: pad, borderRadius: 999,
      background: `${m.c}22`, color: m.c,
      fontFamily: T.font, fontSize: fs, fontWeight: 600, letterSpacing: -0.1,
    }}>
      <div style={{ width: 6, height: 6, borderRadius: 3, background: m.c }} />
      {m.label}
    </span>
  );
}

function Checkbox({ checked, color = T.success, size = 22 }) {
  return checked ? (
    <div style={{
      width: size, height: size, borderRadius: size/2, background: color,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      flexShrink: 0,
    }}>
      <Icon name="check" size={size * 0.65} color="#0E0F13" strokeWidth={2.6} />
    </div>
  ) : (
    <div style={{
      width: size, height: size, borderRadius: size/2,
      border: `1.8px solid ${T.borderStrong}`, flexShrink: 0,
    }} />
  );
}

// Expose globals
Object.assign(window, { T, Icon, BottomNav, AppBar, PhoneShell, CategoryDot, CategoryPill, Checkbox });
