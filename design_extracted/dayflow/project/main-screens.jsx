// main-screens.jsx — The 4 primary screens from the captures, in dark mode.
// Home, Tareas, Hábitos, Estadísticas.

// ─────────────────────────────────────────────────────────────
// 1. HOME / DASHBOARD
// ─────────────────────────────────────────────────────────────
function HomeScreen() {
  const summary = [
    { label: 'Actividades\ntotales',  value: 5, color: T.blue,     icon: 'calendar' },
    { label: 'Completadas',           value: 3, color: T.health,   icon: 'check'    },
    { label: 'Pendientes',            value: 2, color: T.personal, icon: 'clock'    },
  ];
  const upcoming = [
    { time: '10:00', title: 'Estudiar Matemáticas', cat: 'academic' },
    { time: '11:30', title: 'Entrenamiento',        cat: 'health'   },
    { time: '15:00', title: 'Comprar mercado',      cat: 'personal' },
    { time: '18:30', title: 'Leer 20 páginas',      cat: 'academic' },
  ];
  return (
    <PhoneShell activeTab="home">
      <AppBar title="DayFlow" />

      <div style={{ padding: '8px 20px 24px' }}>
        {/* Greeting */}
        <div style={{ fontFamily: T.font, color: T.text,
                      fontSize: 28, fontWeight: 700, letterSpacing: -0.6, lineHeight: 1.15 }}>
          ¡Hola, Juan!
        </div>
        <div style={{ marginTop: 6, fontFamily: T.font, color: T.textDim,
                      fontSize: 14, fontWeight: 500 }}>
          Miércoles, 14 de mayo
        </div>

        {/* Section: Resumen de hoy */}
        <SectionTitle>Resumen de hoy</SectionTitle>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10 }}>
          {summary.map((s, i) => (
            <div key={i} style={{
              background: s.color, borderRadius: 16, padding: '14px 12px',
              display: 'flex', flexDirection: 'column', justifyContent: 'space-between',
              minHeight: 116, color: '#0E0F13',
              boxShadow: `0 8px 20px ${s.color}30`,
            }}>
              <div style={{
                width: 30, height: 30, borderRadius: 8,
                background: 'rgba(255,255,255,0.25)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Icon name={s.icon} size={18} color="#fff" strokeWidth={2.2} />
              </div>
              <div>
                <div style={{ fontFamily: T.font, fontSize: 32, fontWeight: 800,
                              color: '#fff', lineHeight: 1, letterSpacing: -1 }}>
                  {s.value}
                </div>
                <div style={{ marginTop: 6, fontFamily: T.font, fontSize: 11.5,
                              fontWeight: 600, color: 'rgba(255,255,255,0.92)',
                              whiteSpace: 'pre-line', letterSpacing: -0.1, lineHeight: 1.2 }}>
                  {s.label}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Section: Próximas actividades */}
        <SectionTitle>Próximas actividades</SectionTitle>
        <div style={{ background: T.surface, borderRadius: 16,
                      border: `1px solid ${T.border}`, overflow: 'hidden' }}>
          {upcoming.map((u, i) => (
            <div key={i} style={{
              display: 'flex', alignItems: 'center', gap: 14,
              padding: '14px 16px',
              borderBottom: i < upcoming.length - 1 ? `1px solid ${T.border}` : 'none',
            }}>
              <div style={{
                fontFamily: T.font, fontSize: 14, fontWeight: 700,
                color: T.text, width: 48, fontVariantNumeric: 'tabular-nums',
                letterSpacing: -0.3,
              }}>{u.time}</div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ fontFamily: T.font, fontSize: 14.5, fontWeight: 600,
                              color: T.text, letterSpacing: -0.2 }}>
                  {u.title}
                </div>
                <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 11.5,
                              color: T.textDim, fontWeight: 500 }}>
                  ({{academic:'Académica', health:'Salud', personal:'Personal'}[u.cat]})
                </div>
              </div>
              <CategoryDot category={u.cat} size={10} />
            </div>
          ))}
        </div>

        {/* Quick action callout */}
        <div style={{
          marginTop: 18, padding: '14px 16px', borderRadius: 16,
          background: `linear-gradient(135deg, ${T.blueSoft}, rgba(34,197,94,0.08))`,
          border: `1px solid ${T.border}`,
          display: 'flex', alignItems: 'center', gap: 12,
        }}>
          <div style={{ width: 36, height: 36, borderRadius: 10,
                        background: T.blueSoft, color: T.blue,
                        display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <Icon name="sparkle" size={20} />
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ fontFamily: T.font, fontSize: 13.5, fontWeight: 600, color: T.text }}>
              Vas por buen camino
            </div>
            <div style={{ fontFamily: T.font, fontSize: 11.5, color: T.textDim, marginTop: 1 }}>
              60% de tus actividades hechas
            </div>
          </div>
          <Icon name="chevron-right" size={18} color={T.textDim} />
        </div>
      </div>
    </PhoneShell>
  );
}

function SectionTitle({ children }) {
  return (
    <div style={{
      fontFamily: T.font, fontSize: 16.5, fontWeight: 700, color: T.text,
      letterSpacing: -0.2, margin: '24px 0 12px',
    }}>{children}</div>
  );
}

// ─────────────────────────────────────────────────────────────
// 2. TAREAS
// ─────────────────────────────────────────────────────────────
function TareasScreen() {
  const [filter, setFilter] = React.useState('Todas');
  const filters = ['Todas', 'Personal', 'Académica', 'Salud'];

  const today = [
    { title: 'Estudiar Matemáticas', time: '10:00 AM', cat: 'academic', done: false },
    { title: 'Leer 20 páginas',      time: '1:00 PM',  cat: 'academic', done: true  },
    { title: 'Comprar mercado',      time: '3:00 PM',  cat: 'personal', done: false },
    { title: 'Entrenamiento',        time: '5:30 PM',  cat: 'health',   done: false },
  ];
  const tomorrow = [
    { title: 'Entrega proyecto', time: '9:00 AM',  cat: 'academic', done: false },
    { title: 'Llamar al médico', time: '11:00 AM', cat: 'personal', done: false },
  ];

  const visible = (list) => filter === 'Todas'
    ? list
    : list.filter(t => ({Personal:'personal', Académica:'academic', Salud:'health'})[filter] === t.cat);

  return (
    <PhoneShell activeTab="tasks">
      <AppBar left="menu" title="Tareas" right="plus" />

      {/* Filter chips */}
      <div style={{
        display: 'flex', gap: 8, padding: '4px 20px 16px',
        overflowX: 'auto',
      }}>
        {filters.map(f => {
          const active = f === filter;
          return (
            <button key={f} onClick={() => setFilter(f)} style={{
              padding: '8px 16px', borderRadius: 999,
              border: active ? 'none' : `1px solid ${T.borderStrong}`,
              background: active ? T.blue : 'transparent',
              color: active ? '#fff' : T.textDim,
              fontFamily: T.font, fontSize: 13, fontWeight: 600,
              letterSpacing: -0.1, cursor: 'pointer', flexShrink: 0,
              transition: 'all .15s',
            }}>{f}</button>
          );
        })}
      </div>

      <div style={{ padding: '0 20px 24px' }}>
        <TaskGroup title="Hoy" items={visible(today)} />
        <TaskGroup title="Mañana" items={visible(tomorrow)} top />
      </div>
    </PhoneShell>
  );
}

function TaskGroup({ title, items, top }) {
  if (!items.length) return null;
  return (
    <>
      <div style={{
        fontFamily: T.font, fontSize: 13, fontWeight: 700, color: T.textDim,
        letterSpacing: 0.8, textTransform: 'uppercase',
        margin: top ? '22px 0 12px' : '4px 0 12px',
      }}>{title}</div>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
        {items.map((t, i) => (
          <div key={i} style={{
            background: T.surface, borderRadius: 14,
            border: `1px solid ${T.border}`,
            padding: '14px 14px', display: 'flex', alignItems: 'center', gap: 12,
          }}>
            <Checkbox checked={t.done} color={
              { academic: T.academic, health: T.health, personal: T.personal }[t.cat]
            } />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{
                fontFamily: T.font, fontSize: 14.5, fontWeight: 600,
                color: t.done ? T.textDim : T.text, letterSpacing: -0.2,
                textDecoration: t.done ? 'line-through' : 'none',
              }}>{t.title}</div>
              <div style={{ marginTop: 3, display: 'flex', alignItems: 'center', gap: 8 }}>
                <Icon name="clock" size={12} color={T.textMute} />
                <span style={{ fontFamily: T.font, fontSize: 12, color: T.textMute,
                               fontWeight: 500, fontVariantNumeric: 'tabular-nums' }}>
                  {t.time}
                </span>
              </div>
            </div>
            <CategoryDot category={t.cat} size={10} />
          </div>
        ))}
      </div>
    </>
  );
}

// ─────────────────────────────────────────────────────────────
// 3. HÁBITOS
// ─────────────────────────────────────────────────────────────
function HabitosScreen() {
  const habits = [
    { name: 'Beber 2L de agua',  icon: 'water',     color: '#38BDF8', done: true  },
    { name: 'Ejercicio 30 min',  icon: 'dumbbell',  color: T.health,  done: true  },
    { name: 'Meditación 10 min', icon: 'leaf',      color: '#A78BFA', done: false },
    { name: 'Dormir 7-8 horas',  icon: 'moon',      color: '#6366F1', done: true  },
    { name: 'Leer antes de dormir', icon: 'book',   color: T.personal, done: false },
  ];
  const completed = habits.filter(h => h.done).length;
  return (
    <PhoneShell activeTab="habits">
      <AppBar left="menu" title="Hábitos" right="plus" />

      <div style={{ padding: '8px 20px 24px' }}>
        {/* Streak card */}
        <div style={{
          background: 'linear-gradient(135deg, rgba(245,158,11,0.18), rgba(239,68,68,0.10))',
          border: `1px solid rgba(245,158,11,0.25)`,
          borderRadius: 18, padding: '18px 18px',
          display: 'flex', alignItems: 'center', gap: 18,
        }}>
          <div style={{
            width: 64, height: 64, borderRadius: 18,
            background: 'rgba(245,158,11,0.18)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            color: T.personal, flexShrink: 0,
          }}>
            <Icon name="flame" size={36} color="#F97316" />
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ fontFamily: T.font, fontSize: 12.5, fontWeight: 700,
                          color: T.personal, letterSpacing: 1, textTransform: 'uppercase' }}>
              Racha diaria
            </div>
            <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 38,
                          fontWeight: 800, color: T.text, lineHeight: 1, letterSpacing: -1.5 }}>
              12
            </div>
            <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 13,
                          color: T.textDim, fontWeight: 500 }}>
              días seguidos
            </div>
          </div>
        </div>

        {/* Today progress mini */}
        <div style={{ marginTop: 14,
                      display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <div>
            <div style={{ fontFamily: T.font, fontSize: 16.5, fontWeight: 700,
                          color: T.text, letterSpacing: -0.2 }}>
              Hábitos de hoy
            </div>
            <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 12,
                          color: T.textDim, fontWeight: 500 }}>
              {completed} de {habits.length} completados
            </div>
          </div>
          <div style={{
            padding: '6px 12px', borderRadius: 999,
            background: T.blueSoft, color: T.blue,
            fontFamily: T.font, fontSize: 12, fontWeight: 700,
            fontVariantNumeric: 'tabular-nums',
          }}>{Math.round(completed/habits.length*100)}%</div>
        </div>

        {/* Habits list */}
        <div style={{ marginTop: 12, background: T.surface, borderRadius: 16,
                      border: `1px solid ${T.border}`, overflow: 'hidden' }}>
          {habits.map((h, i) => (
            <div key={i} style={{
              display: 'flex', alignItems: 'center', gap: 14,
              padding: '14px 16px',
              borderBottom: i < habits.length - 1 ? `1px solid ${T.border}` : 'none',
            }}>
              <div style={{
                width: 36, height: 36, borderRadius: 10,
                background: `${h.color}22`, color: h.color,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                flexShrink: 0,
              }}>
                <Icon name={h.icon} size={20} color={h.color} />
              </div>
              <div style={{ flex: 1,
                            fontFamily: T.font, fontSize: 14.5, fontWeight: 600,
                            color: h.done ? T.textDim : T.text, letterSpacing: -0.2 }}>
                {h.name}
              </div>
              {h.done
                ? <Icon name="check-circle-fill" size={24} color={T.success} />
                : <div style={{ width: 24, height: 24, borderRadius: 12,
                                border: `1.8px solid ${T.borderStrong}` }} />}
            </div>
          ))}
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 4. ESTADÍSTICAS
// ─────────────────────────────────────────────────────────────
function EstadisticasScreen() {
  // Donut: 78% completed
  const pct = 78;
  const r = 64, c = 2 * Math.PI * r;
  const dash = c * pct / 100;

  const week = [
    { d: 'Lun', v: 70 }, { d: 'Mar', v: 85 }, { d: 'Mié', v: 60 },
    { d: 'Jue', v: 92 }, { d: 'Vie', v: 75 }, { d: 'Sáb', v: 45, dim: true },
    { d: 'Dom', v: 30, dim: true },
  ];
  const maxV = Math.max(...week.map(w => w.v));

  return (
    <PhoneShell activeTab="stats">
      <AppBar left="menu" title="Estadísticas" right="more" />

      <div style={{ padding: '8px 20px 24px' }}>
        {/* Period header card */}
        <div style={{
          background: T.surface, borderRadius: 18,
          border: `1px solid ${T.border}`,
          padding: '16px 16px 20px',
        }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
            <button style={{ width: 32, height: 32, borderRadius: 8, border: 'none',
                             background: T.surface2, color: T.textDim, cursor: 'pointer',
                             display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name="chevron-left" size={16} />
            </button>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontFamily: T.font, fontSize: 14.5, fontWeight: 700,
                            color: T.text, letterSpacing: -0.2 }}>
                Esta semana
              </div>
              <div style={{ fontFamily: T.font, fontSize: 11.5, color: T.textDim,
                            marginTop: 1, fontWeight: 500 }}>
                8 – 14 de mayo
              </div>
            </div>
            <button style={{ width: 32, height: 32, borderRadius: 8, border: 'none',
                             background: T.surface2, color: T.textDim, cursor: 'pointer',
                             display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name="chevron-right" size={16} />
            </button>
          </div>

          {/* Donut */}
          <div style={{ display: 'flex', justifyContent: 'center', marginTop: 16 }}>
            <div style={{ position: 'relative', width: 160, height: 160 }}>
              <svg width="160" height="160" viewBox="0 0 160 160" style={{ transform: 'rotate(-90deg)' }}>
                <circle cx="80" cy="80" r={r} fill="none"
                        stroke={T.surface2} strokeWidth="14" />
                <circle cx="80" cy="80" r={r} fill="none"
                        stroke={T.blue} strokeWidth="14" strokeLinecap="round"
                        strokeDasharray={`${dash} ${c}`} />
              </svg>
              <div style={{
                position: 'absolute', inset: 0, display: 'flex',
                flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
              }}>
                <div style={{ fontFamily: T.font, fontSize: 36, fontWeight: 800,
                              color: T.text, letterSpacing: -1.5, lineHeight: 1 }}>
                  {pct}%
                </div>
                <div style={{ marginTop: 4, fontFamily: T.font, fontSize: 12,
                              color: T.textDim, fontWeight: 500 }}>
                  Completado
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Stat row */}
        <div style={{ marginTop: 14, display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10 }}>
          {[
            { v: 21, label: 'Completadas', c: T.health   },
            { v: 6,  label: 'Pendientes',  c: T.personal },
            { v: 3,  label: 'Omitidas',    c: T.danger   },
          ].map((s, i) => (
            <div key={i} style={{
              background: T.surface, borderRadius: 14,
              border: `1px solid ${T.border}`,
              padding: '14px 10px', textAlign: 'center',
            }}>
              <div style={{ fontFamily: T.font, fontSize: 24, fontWeight: 800,
                            color: s.c, letterSpacing: -0.6, lineHeight: 1 }}>
                {s.v}
              </div>
              <div style={{ marginTop: 6, fontFamily: T.font, fontSize: 11.5,
                            color: T.textDim, fontWeight: 500, letterSpacing: -0.1 }}>
                {s.label}
              </div>
            </div>
          ))}
        </div>

        {/* Weekly bars */}
        <div style={{ marginTop: 14, background: T.surface, borderRadius: 16,
                      border: `1px solid ${T.border}`, padding: '16px 14px 14px' }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                        marginBottom: 12 }}>
            <div style={{ fontFamily: T.font, fontSize: 13.5, fontWeight: 700,
                          color: T.text, letterSpacing: -0.2 }}>
              Cumplimiento semanal
            </div>
            <div style={{ fontFamily: T.font, fontSize: 11, color: T.textDim,
                          fontWeight: 500 }}>%</div>
          </div>
          <div style={{ display: 'flex', alignItems: 'flex-end',
                        justifyContent: 'space-between', height: 110, gap: 6 }}>
            {week.map((w, i) => (
              <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column',
                                    alignItems: 'center', gap: 6 }}>
                <div style={{
                  width: '100%', height: `${(w.v / maxV) * 90}px`,
                  background: w.dim ? T.surfaceHi : T.blue,
                  borderRadius: 6,
                  boxShadow: w.dim ? 'none' : `0 0 12px ${T.blue}55`,
                  transition: 'height .3s',
                }} />
                <div style={{ fontFamily: T.font, fontSize: 11,
                              color: w.dim ? T.textMute : T.textDim,
                              fontWeight: 600, letterSpacing: -0.1 }}>
                  {w.d}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </PhoneShell>
  );
}

Object.assign(window, { HomeScreen, TareasScreen, HabitosScreen, EstadisticasScreen });
