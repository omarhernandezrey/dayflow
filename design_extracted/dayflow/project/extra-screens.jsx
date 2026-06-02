// extra-screens.jsx — Additional screens completing the DayFlow app.
// Add Task, Add Habit, Task Detail, Notifications, Menu (drawer), Profile.

// ─────────────────────────────────────────────────────────────
// 5. ADD TASK — RF1 Registrar actividad
// ─────────────────────────────────────────────────────────────
function AddTaskScreen() {
  const [cat, setCat] = React.useState('academic');
  const [reminder, setReminder] = React.useState('15');
  const cats = [
    { id: 'personal', label: 'Personal',  icon: 'user',       c: T.personal },
    { id: 'academic', label: 'Académica', icon: 'book',       c: T.academic },
    { id: 'health',   label: 'Salud',     icon: 'stethoscope', c: T.health  },
  ];
  return (
    <PhoneShell hideNav>
      <AppBar left="chevron-left" title="Nueva tarea" right={null} />
      <div style={{ padding: '8px 20px 28px' }}>

        <Field label="Título">
          <div style={inputBox}>
            <span style={{ color: T.text, fontFamily: T.font, fontSize: 15, fontWeight: 500 }}>
              Estudiar Matemáticas
            </span>
            <div style={{ width: 1.5, height: 18, background: T.blue, marginLeft: 2,
                          animation: 'dfBlink 1s steps(2) infinite' }} />
          </div>
        </Field>

        <Field label="Descripción">
          <div style={{ ...inputBox, minHeight: 80, alignItems: 'flex-start', paddingTop: 12 }}>
            <span style={{ color: T.textMute, fontFamily: T.font, fontSize: 14 }}>
              Capítulo 4: derivadas y aplicaciones.
            </span>
          </div>
        </Field>

        <Field label="Categoría">
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 8 }}>
            {cats.map(c => {
              const active = cat === c.id;
              return (
                <button key={c.id} onClick={() => setCat(c.id)} style={{
                  padding: '14px 8px', borderRadius: 14,
                  background: active ? `${c.c}22` : T.surface,
                  border: `1.5px solid ${active ? c.c : T.border}`,
                  display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6,
                  cursor: 'pointer', transition: 'all .15s',
                }}>
                  <Icon name={c.icon} size={20} color={active ? c.c : T.textDim} />
                  <span style={{ fontFamily: T.font, fontSize: 12.5, fontWeight: 600,
                                 color: active ? c.c : T.textDim, letterSpacing: -0.1 }}>
                    {c.label}
                  </span>
                </button>
              );
            })}
          </div>
        </Field>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
          <Field label="Fecha">
            <div style={inputBox}>
              <Icon name="calendar" size={18} color={T.textDim} />
              <span style={{ color: T.text, fontFamily: T.font, fontSize: 14, fontWeight: 500 }}>
                14 mayo
              </span>
            </div>
          </Field>
          <Field label="Hora">
            <div style={inputBox}>
              <Icon name="clock" size={18} color={T.textDim} />
              <span style={{ color: T.text, fontFamily: T.font, fontSize: 14, fontWeight: 500 }}>
                10:00 AM
              </span>
            </div>
          </Field>
        </div>

        <Field label="Recordatorio">
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
            {['5', '15', '30', '60'].map(m => {
              const active = m === reminder;
              return (
                <button key={m} onClick={() => setReminder(m)} style={{
                  padding: '8px 14px', borderRadius: 999,
                  background: active ? T.blue : T.surface,
                  border: `1.5px solid ${active ? T.blue : T.border}`,
                  color: active ? '#fff' : T.textDim,
                  fontFamily: T.font, fontSize: 13, fontWeight: 600,
                  cursor: 'pointer', letterSpacing: -0.1,
                }}>{m} min antes</button>
              );
            })}
          </div>
        </Field>

        <button style={{
          width: '100%', marginTop: 24, padding: '16px',
          background: T.blue, border: 'none', borderRadius: 14,
          color: '#fff', fontFamily: T.font, fontSize: 15, fontWeight: 700,
          letterSpacing: -0.2, cursor: 'pointer',
          boxShadow: `0 8px 24px ${T.blue}40`,
        }}>Guardar actividad</button>
      </div>
    </PhoneShell>
  );
}

const inputBox = {
  display: 'flex', alignItems: 'center', gap: 10,
  background: T.surface, border: `1px solid ${T.border}`,
  borderRadius: 12, padding: '14px 14px', minHeight: 48,
};

function Field({ label, children }) {
  return (
    <div style={{ marginTop: 16 }}>
      <div style={{
        fontFamily: T.font, fontSize: 12, fontWeight: 700,
        color: T.textDim, letterSpacing: 0.6, textTransform: 'uppercase',
        marginBottom: 8,
      }}>{label}</div>
      {children}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// 6. ADD HABIT — RF8 Gestionar hábitos
// ─────────────────────────────────────────────────────────────
function AddHabitScreen() {
  const [icon, setIcon] = React.useState('water');
  const [freq, setFreq] = React.useState('daily');
  const iconOpts = [
    { id: 'water',     c: '#38BDF8' },
    { id: 'dumbbell',  c: T.health  },
    { id: 'leaf',      c: '#A78BFA' },
    { id: 'moon',      c: '#6366F1' },
    { id: 'book',      c: T.personal},
    { id: 'sparkle',   c: '#F472B6' },
  ];
  const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  const activeIcon = iconOpts.find(i => i.id === icon);

  return (
    <PhoneShell hideNav>
      <AppBar left="chevron-left" title="Nuevo hábito" right={null} />
      <div style={{ padding: '8px 20px 28px' }}>

        {/* Icon preview */}
        <div style={{ display: 'flex', justifyContent: 'center', marginTop: 8 }}>
          <div style={{
            width: 84, height: 84, borderRadius: 24,
            background: `${activeIcon.c}22`,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            border: `1px solid ${activeIcon.c}44`,
          }}>
            <Icon name={icon} size={40} color={activeIcon.c} />
          </div>
        </div>

        <Field label="Nombre del hábito">
          <div style={inputBox}>
            <span style={{ color: T.text, fontFamily: T.font, fontSize: 15, fontWeight: 500 }}>
              Beber 2L de agua
            </span>
          </div>
        </Field>

        <Field label="Icono">
          <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
            {iconOpts.map(o => {
              const active = o.id === icon;
              return (
                <button key={o.id} onClick={() => setIcon(o.id)} style={{
                  width: 48, height: 48, borderRadius: 12,
                  background: active ? `${o.c}33` : T.surface,
                  border: `1.5px solid ${active ? o.c : T.border}`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  cursor: 'pointer', transition: 'all .15s',
                }}>
                  <Icon name={o.id} size={22} color={active ? o.c : T.textDim} />
                </button>
              );
            })}
          </div>
        </Field>

        <Field label="Frecuencia">
          <div style={{ display: 'flex', gap: 8, marginBottom: 12 }}>
            {[
              { id: 'daily',  label: 'Diario' },
              { id: 'weekly', label: 'Semanal' },
              { id: 'custom', label: 'Personalizado' },
            ].map(f => {
              const active = freq === f.id;
              return (
                <button key={f.id} onClick={() => setFreq(f.id)} style={{
                  flex: 1, padding: '10px 8px', borderRadius: 10,
                  background: active ? T.blue : T.surface,
                  border: `1px solid ${active ? T.blue : T.border}`,
                  color: active ? '#fff' : T.textDim,
                  fontFamily: T.font, fontSize: 12.5, fontWeight: 600,
                  cursor: 'pointer', letterSpacing: -0.1,
                }}>{f.label}</button>
              );
            })}
          </div>
          <div style={{ display: 'flex', gap: 6, justifyContent: 'space-between' }}>
            {days.map((d, i) => (
              <div key={i} style={{
                flex: 1, height: 38, borderRadius: 10,
                background: i < 5 ? T.blueSoft : T.surface,
                border: `1px solid ${i < 5 ? T.blue + '55' : T.border}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                color: i < 5 ? T.blue : T.textMute,
                fontFamily: T.font, fontSize: 13, fontWeight: 700,
              }}>{d}</div>
            ))}
          </div>
        </Field>

        <Field label="Meta diaria">
          <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <button style={btnQty}>−</button>
            <div style={{
              flex: 1, textAlign: 'center', padding: '14px',
              background: T.surface, border: `1px solid ${T.border}`,
              borderRadius: 12, color: T.text,
              fontFamily: T.font, fontSize: 16, fontWeight: 700, letterSpacing: -0.3,
            }}>8 vasos</div>
            <button style={btnQty}>+</button>
          </div>
        </Field>

        <button style={{
          width: '100%', marginTop: 24, padding: '16px',
          background: activeIcon.c, border: 'none', borderRadius: 14,
          color: '#fff', fontFamily: T.font, fontSize: 15, fontWeight: 700,
          letterSpacing: -0.2, cursor: 'pointer',
          boxShadow: `0 8px 24px ${activeIcon.c}40`,
        }}>Crear hábito</button>
      </div>
    </PhoneShell>
  );
}

const btnQty = {
  width: 46, height: 46, borderRadius: 12,
  background: T.surface, border: `1px solid ${T.border}`,
  color: T.text, fontFamily: T.font, fontSize: 22, fontWeight: 600,
  cursor: 'pointer',
};

// ─────────────────────────────────────────────────────────────
// 7. TASK DETAIL — view a single activity
// ─────────────────────────────────────────────────────────────
function TaskDetailScreen() {
  return (
    <PhoneShell hideNav>
      <AppBar left="chevron-left" title="Detalle" right="more" />

      <div style={{ padding: '8px 20px 28px' }}>
        {/* Hero card */}
        <div style={{
          background: `linear-gradient(135deg, ${T.academic}, ${T.academic}cc)`,
          borderRadius: 20, padding: '22px 20px',
          color: '#fff',
          boxShadow: `0 12px 32px ${T.academic}40`,
        }}>
          <div style={{ display: 'inline-flex', alignItems: 'center', gap: 6,
                        padding: '4px 10px', borderRadius: 999,
                        background: 'rgba(255,255,255,0.22)' }}>
            <Icon name="book" size={12} color="#fff" />
            <span style={{ fontFamily: T.font, fontSize: 11.5, fontWeight: 700,
                           letterSpacing: 0.2 }}>Académica</span>
          </div>
          <div style={{ marginTop: 14, fontFamily: T.font, fontSize: 24,
                        fontWeight: 800, letterSpacing: -0.6, lineHeight: 1.15 }}>
            Estudiar Matemáticas
          </div>
          <div style={{ marginTop: 6, fontFamily: T.font, fontSize: 13.5,
                        opacity: 0.9, fontWeight: 500 }}>
            Capítulo 4: derivadas y aplicaciones.
          </div>
        </div>

        {/* Meta rows */}
        <div style={{ marginTop: 18, background: T.surface,
                      border: `1px solid ${T.border}`, borderRadius: 16,
                      overflow: 'hidden' }}>
          {[
            { i: 'calendar', l: 'Fecha',        v: 'Miércoles, 14 de mayo' },
            { i: 'clock',    l: 'Hora',         v: '10:00 AM' },
            { i: 'bell',     l: 'Recordatorio', v: '15 minutos antes' },
            { i: 'repeat',   l: 'Repetir',      v: 'No se repite' },
          ].map((r, i, a) => (
            <div key={i} style={{
              display: 'flex', alignItems: 'center', gap: 14,
              padding: '14px 16px',
              borderBottom: i < a.length - 1 ? `1px solid ${T.border}` : 'none',
            }}>
              <div style={{
                width: 34, height: 34, borderRadius: 10,
                background: T.surface2, color: T.textDim,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Icon name={r.i} size={18} color={T.textDim} />
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontFamily: T.font, fontSize: 11.5, color: T.textMute,
                              fontWeight: 600, letterSpacing: 0.4, textTransform: 'uppercase' }}>
                  {r.l}
                </div>
                <div style={{ marginTop: 1, fontFamily: T.font, fontSize: 14.5,
                              color: T.text, fontWeight: 600, letterSpacing: -0.2 }}>
                  {r.v}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Subtasks */}
        <div style={{ marginTop: 18 }}>
          <div style={{ fontFamily: T.font, fontSize: 13, fontWeight: 700,
                        color: T.textDim, letterSpacing: 0.6, textTransform: 'uppercase',
                        marginBottom: 8 }}>Subtareas</div>
          {[
            { t: 'Repasar derivadas básicas', d: true },
            { t: 'Resolver ejercicios 1–10',   d: true },
            { t: 'Hacer resumen del capítulo', d: false },
          ].map((s, i) => (
            <div key={i} style={{
              display: 'flex', alignItems: 'center', gap: 12,
              padding: '12px 14px', borderRadius: 12,
              background: T.surface, border: `1px solid ${T.border}`,
              marginBottom: 8,
            }}>
              <Checkbox checked={s.d} color={T.academic} size={20} />
              <span style={{ fontFamily: T.font, fontSize: 14, fontWeight: 500,
                             color: s.d ? T.textDim : T.text,
                             textDecoration: s.d ? 'line-through' : 'none' }}>
                {s.t}
              </span>
            </div>
          ))}
        </div>

        {/* Action buttons */}
        <div style={{ marginTop: 22, display: 'flex', gap: 10 }}>
          <button style={{
            flex: 1, padding: '14px', borderRadius: 12,
            background: T.surface, border: `1px solid ${T.border}`,
            color: T.text, fontFamily: T.font, fontSize: 14, fontWeight: 600,
            cursor: 'pointer', display: 'flex', alignItems: 'center',
            justifyContent: 'center', gap: 8,
          }}>
            <Icon name="edit" size={16} color={T.text} /> Editar
          </button>
          <button style={{
            flex: 1, padding: '14px', borderRadius: 12,
            background: T.success, border: 'none',
            color: '#0E0F13', fontFamily: T.font, fontSize: 14, fontWeight: 700,
            cursor: 'pointer', display: 'flex', alignItems: 'center',
            justifyContent: 'center', gap: 8,
            boxShadow: `0 6px 16px ${T.success}40`,
          }}>
            <Icon name="check" size={16} color="#0E0F13" strokeWidth={2.4}/> Completar
          </button>
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 8. NOTIFICATIONS — RF4 Generar notificaciones locales
// ─────────────────────────────────────────────────────────────
function NotificationsScreen() {
  const notifs = [
    { time: 'Ahora', icon: 'clock', c: T.academic,
      title: 'Estudiar Matemáticas',
      text: 'Comienza en 15 minutos', isNew: true },
    { time: 'Hace 1 h', icon: 'flame', c: T.personal,
      title: '¡12 días de racha!',
      text: 'Has mantenido tu racha de hábitos durante 12 días.', isNew: true },
    { time: 'Hace 3 h', icon: 'check-circle-fill', c: T.success,
      title: 'Hábito completado',
      text: 'Marcaste «Ejercicio 30 min» como hecho.' },
    { time: 'Ayer', icon: 'trophy', c: '#F472B6',
      title: 'Semana al 78%',
      text: 'Tu mejor semana del mes hasta ahora.' },
    { time: 'Ayer', icon: 'bell', c: T.textDim,
      title: 'Entrenamiento',
      text: 'Recordatorio: empieza a las 5:30 PM.' },
  ];
  return (
    <PhoneShell hideNav>
      <AppBar left="chevron-left" title="Notificaciones" right="settings" />

      <div style={{ padding: '8px 20px 28px' }}>
        <div style={{
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          marginBottom: 14,
        }}>
          <span style={{ fontFamily: T.font, fontSize: 12.5, color: T.textDim,
                         fontWeight: 500 }}>
            2 sin leer
          </span>
          <button style={{
            background: 'transparent', border: 'none', cursor: 'pointer',
            color: T.blue, fontFamily: T.font, fontSize: 12.5, fontWeight: 600,
          }}>Marcar todo como leído</button>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {notifs.map((n, i) => (
            <div key={i} style={{
              display: 'flex', gap: 12,
              padding: '14px 14px', borderRadius: 14,
              background: n.isNew ? T.surface : 'transparent',
              border: `1px solid ${n.isNew ? T.border : 'transparent'}`,
              position: 'relative',
            }}>
              <div style={{
                width: 40, height: 40, borderRadius: 12,
                background: `${n.c}22`, color: n.c, flexShrink: 0,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Icon name={n.icon} size={20} color={n.c} />
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ display: 'flex', alignItems: 'baseline',
                              justifyContent: 'space-between', gap: 8 }}>
                  <div style={{ fontFamily: T.font, fontSize: 14, fontWeight: 700,
                                color: T.text, letterSpacing: -0.2 }}>
                    {n.title}
                  </div>
                  <div style={{ fontFamily: T.font, fontSize: 11,
                                color: T.textMute, fontWeight: 500, flexShrink: 0 }}>
                    {n.time}
                  </div>
                </div>
                <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 12.5,
                              color: T.textDim, lineHeight: 1.4, fontWeight: 500 }}>
                  {n.text}
                </div>
              </div>
              {n.isNew && (
                <div style={{
                  position: 'absolute', top: 18, right: -2,
                  width: 8, height: 8, borderRadius: 4, background: T.blue,
                }} />
              )}
            </div>
          ))}
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 9. MENU / DRAWER — accessed from the burger icon in main screens
// ─────────────────────────────────────────────────────────────
function MenuScreen() {
  const items = [
    { i: 'user',     l: 'Mi perfil',         s: 'Datos personales' },
    { i: 'trophy',   l: 'Logros',            s: '8 conseguidos',     badge: '+2' },
    { i: 'palette',  l: 'Apariencia',        s: 'Tema oscuro' },
    { i: 'bell',     l: 'Notificaciones',    s: 'Activadas' },
    { i: 'tag',      l: 'Categorías',        s: 'Personal, Académica, Salud' },
    { i: 'shield',   l: 'Privacidad y datos', s: 'Almacenamiento local' },
    { i: 'help',     l: 'Ayuda y soporte',   s: 'Centro de ayuda' },
  ];

  return (
    <PhoneShell hideNav>
      {/* Backdrop hint that drawer is overlaid on app */}
      <div style={{
        position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.5)',
        zIndex: 1, pointerEvents: 'none',
      }} />
      <div style={{
        position: 'relative', zIndex: 2,
        width: '85%', height: '100%', background: T.bg,
        boxShadow: '8px 0 32px rgba(0,0,0,0.5)',
        display: 'flex', flexDirection: 'column',
      }}>
        {/* Profile header */}
        <div style={{ padding: '70px 22px 22px',
                      background: `linear-gradient(180deg, ${T.surface} 0%, ${T.bg} 100%)`,
                      borderBottom: `1px solid ${T.border}` }}>
          <div style={{
            width: 60, height: 60, borderRadius: 30,
            background: `linear-gradient(135deg, ${T.blue}, #A78BFA)`,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            color: '#fff', fontFamily: T.font, fontSize: 24, fontWeight: 700,
            letterSpacing: -0.5,
          }}>JD</div>
          <div style={{ marginTop: 12, fontFamily: T.font, fontSize: 18,
                        fontWeight: 700, color: T.text, letterSpacing: -0.3 }}>
            Juan David
          </div>
          <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 12.5,
                        color: T.textDim, fontWeight: 500 }}>
            juan.quiceno@dayflow.app
          </div>
        </div>

        {/* Items */}
        <div style={{ flex: 1, overflow: 'auto', padding: '8px 12px' }}>
          {items.map((it, i) => (
            <button key={i} style={{
              width: '100%', display: 'flex', alignItems: 'center', gap: 14,
              padding: '12px 12px', borderRadius: 12,
              background: 'transparent', border: 'none', cursor: 'pointer',
              textAlign: 'left', marginBottom: 2,
            }}>
              <div style={{
                width: 36, height: 36, borderRadius: 10,
                background: T.surface, color: T.text,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Icon name={it.i} size={18} color={T.text} />
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontFamily: T.font, fontSize: 14.5, fontWeight: 600,
                              color: T.text, letterSpacing: -0.2 }}>{it.l}</div>
                <div style={{ marginTop: 1, fontFamily: T.font, fontSize: 11.5,
                              color: T.textMute, fontWeight: 500 }}>{it.s}</div>
              </div>
              {it.badge && (
                <span style={{
                  padding: '2px 8px', borderRadius: 999, background: T.blue,
                  color: '#fff', fontFamily: T.font, fontSize: 11, fontWeight: 700,
                }}>{it.badge}</span>
              )}
              <Icon name="chevron-right" size={16} color={T.textMute} />
            </button>
          ))}
        </div>

        {/* Logout */}
        <div style={{ padding: '12px 16px 40px' }}>
          <button style={{
            width: '100%', display: 'flex', alignItems: 'center', justifyContent: 'center',
            gap: 10, padding: '14px',
            background: 'transparent', border: `1px solid ${T.borderStrong}`,
            borderRadius: 12, color: T.danger,
            fontFamily: T.font, fontSize: 14, fontWeight: 600, cursor: 'pointer',
          }}>
            <Icon name="logout" size={18} color={T.danger} />
            Cerrar sesión
          </button>
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 10. PROFILE / ACHIEVEMENTS — Más → Mi perfil
// ─────────────────────────────────────────────────────────────
function ProfileScreen() {
  const achievements = [
    { i: 'flame',   t: 'Racha de 10 días',  c: T.personal, unlocked: true },
    { i: 'trophy',  t: 'Semana perfecta',   c: '#F472B6', unlocked: true },
    { i: 'water',   t: 'Hidratado',         c: '#38BDF8', unlocked: true },
    { i: 'book',    t: 'Lector ávido',      c: T.academic, unlocked: true },
    { i: 'dumbbell', t: '30 entrenos',       c: T.health,   unlocked: false },
    { i: 'sparkle', t: 'Madrugador',        c: '#FBBF24', unlocked: false },
  ];
  return (
    <PhoneShell activeTab="more">
      <AppBar left="chevron-left" title="Mi perfil" right="settings" />

      <div style={{ padding: '8px 20px 24px' }}>
        {/* Avatar block */}
        <div style={{ textAlign: 'center', marginTop: 4 }}>
          <div style={{
            width: 86, height: 86, borderRadius: 43, margin: '0 auto',
            background: `linear-gradient(135deg, ${T.blue}, #A78BFA)`,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            color: '#fff', fontFamily: T.font, fontSize: 32, fontWeight: 700,
            letterSpacing: -0.6,
            boxShadow: `0 12px 32px ${T.blue}40`,
          }}>JD</div>
          <div style={{ marginTop: 12, fontFamily: T.font, fontSize: 20,
                        fontWeight: 700, color: T.text, letterSpacing: -0.3 }}>
            Juan David Quiceno
          </div>
          <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 12.5,
                        color: T.textDim, fontWeight: 500 }}>
            Miembro desde marzo 2026
          </div>
        </div>

        {/* Stat strip */}
        <div style={{ marginTop: 22, display: 'grid',
                      gridTemplateColumns: '1fr 1fr 1fr', gap: 10 }}>
          {[
            { v: '42', l: 'Hábitos hechos' },
            { v: '12', l: 'Racha actual' },
            { v: '78%', l: 'Esta semana' },
          ].map((s, i) => (
            <div key={i} style={{
              background: T.surface, borderRadius: 14,
              border: `1px solid ${T.border}`, padding: '14px 8px',
              textAlign: 'center',
            }}>
              <div style={{ fontFamily: T.font, fontSize: 20, fontWeight: 800,
                            color: T.text, letterSpacing: -0.4, lineHeight: 1 }}>
                {s.v}
              </div>
              <div style={{ marginTop: 6, fontFamily: T.font, fontSize: 11,
                            color: T.textDim, fontWeight: 500, letterSpacing: -0.1 }}>
                {s.l}
              </div>
            </div>
          ))}
        </div>

        {/* Achievements */}
        <div style={{ marginTop: 22, display: 'flex',
                      alignItems: 'center', justifyContent: 'space-between' }}>
          <div style={{ fontFamily: T.font, fontSize: 16, fontWeight: 700,
                        color: T.text, letterSpacing: -0.2 }}>
            Logros
          </div>
          <span style={{ fontFamily: T.font, fontSize: 12, color: T.textDim,
                         fontWeight: 600 }}>4 / 6</span>
        </div>
        <div style={{ marginTop: 12, display: 'grid',
                      gridTemplateColumns: '1fr 1fr 1fr', gap: 10 }}>
          {achievements.map((a, i) => (
            <div key={i} style={{
              background: T.surface, borderRadius: 14,
              border: `1px solid ${T.border}`, padding: '14px 8px',
              textAlign: 'center',
              opacity: a.unlocked ? 1 : 0.45,
            }}>
              <div style={{
                width: 44, height: 44, borderRadius: 12, margin: '0 auto',
                background: a.unlocked ? `${a.c}22` : T.surface2,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                filter: a.unlocked ? 'none' : 'grayscale(1)',
              }}>
                <Icon name={a.i} size={22} color={a.unlocked ? a.c : T.textMute} />
              </div>
              <div style={{ marginTop: 8, fontFamily: T.font, fontSize: 11.5,
                            fontWeight: 600, color: T.text, letterSpacing: -0.1,
                            lineHeight: 1.2 }}>
                {a.t}
              </div>
            </div>
          ))}
        </div>

        {/* Settings shortcuts */}
        <div style={{ marginTop: 22, background: T.surface,
                      border: `1px solid ${T.border}`, borderRadius: 16,
                      overflow: 'hidden' }}>
          {[
            { i: 'settings', l: 'Configuración' },
            { i: 'shield',   l: 'Privacidad' },
            { i: 'help',     l: 'Ayuda' },
          ].map((it, i, a) => (
            <div key={i} style={{
              display: 'flex', alignItems: 'center', gap: 14,
              padding: '14px 16px',
              borderBottom: i < a.length - 1 ? `1px solid ${T.border}` : 'none',
            }}>
              <Icon name={it.i} size={18} color={T.textDim} />
              <span style={{ flex: 1, fontFamily: T.font, fontSize: 14,
                             fontWeight: 600, color: T.text, letterSpacing: -0.2 }}>
                {it.l}
              </span>
              <Icon name="chevron-right" size={16} color={T.textMute} />
            </div>
          ))}
        </div>
      </div>
    </PhoneShell>
  );
}

Object.assign(window, {
  AddTaskScreen, AddHabitScreen, TaskDetailScreen,
  NotificationsScreen, MenuScreen, ProfileScreen,
});
