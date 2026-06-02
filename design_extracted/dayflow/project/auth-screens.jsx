// auth-screens.jsx — Authentication flow + the "Más" tab.
// Splash, Login, Register, Forgot password, Más (More tab).

// ─────────────────────────────────────────────────────────────
// Shared auth chrome
// ─────────────────────────────────────────────────────────────
function AuthHeader({ back = false, onBack }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'center',
      padding: '0 16px', height: 56, marginTop: 8,
      position: 'relative', zIndex: 5,
    }}>
      {back && (
        <button onClick={onBack} style={{
          width: 40, height: 40, borderRadius: 12, border: 'none',
          background: T.surface, color: T.text, cursor: 'pointer',
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          border: `1px solid ${T.border}`,
        }}>
          <Icon name="chevron-left" size={20} />
        </button>
      )}
    </div>
  );
}

function Logo({ size = 56 }) {
  // DayFlow mark — stylized "D" with a flowing accent
  return (
    <div style={{
      width: size, height: size, borderRadius: size * 0.28,
      background: `linear-gradient(135deg, ${T.blue} 0%, #7C3AED 100%)`,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      position: 'relative', overflow: 'hidden',
      boxShadow: `0 12px 32px ${T.blue}50`,
    }}>
      <svg width={size * 0.6} height={size * 0.6} viewBox="0 0 24 24" fill="none">
        <path d="M5 4h7a8 8 0 010 16H5V4z" fill="#fff"/>
        <circle cx="17" cy="12" r="2.2" fill={T.blue}/>
      </svg>
      <div style={{
        position: 'absolute', top: '-30%', right: '-30%',
        width: '70%', height: '70%', borderRadius: '50%',
        background: 'rgba(255,255,255,0.18)',
      }} />
    </div>
  );
}

function TextField({ label, value, placeholder, icon, type = 'text', focused = false, trailing }) {
  return (
    <div style={{ marginTop: 14 }}>
      <div style={{
        fontFamily: T.font, fontSize: 12, fontWeight: 700,
        color: T.textDim, letterSpacing: 0.4, textTransform: 'uppercase',
        marginBottom: 8,
      }}>{label}</div>
      <div style={{
        display: 'flex', alignItems: 'center', gap: 10,
        background: T.surface, border: `1.5px solid ${focused ? T.blue : T.border}`,
        borderRadius: 12, padding: '0 14px', height: 52,
        boxShadow: focused ? `0 0 0 4px ${T.blue}22` : 'none',
        transition: 'all .15s',
      }}>
        {icon && <Icon name={icon} size={18} color={focused ? T.blue : T.textDim} />}
        <div style={{ flex: 1, minWidth: 0,
                      fontFamily: T.font, fontSize: 15, fontWeight: 500,
                      color: value ? T.text : T.textMute,
                      whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
          {type === 'password' && value ? '•'.repeat(value.length) : (value || placeholder)}
        </div>
        {focused && (
          <div style={{ width: 1.5, height: 18, background: T.blue, marginLeft: -8,
                        animation: 'dfBlink 1s steps(2) infinite' }} />
        )}
        {trailing}
      </div>
    </div>
  );
}

function PrimaryButton({ children, color = T.blue }) {
  return (
    <button style={{
      width: '100%', padding: '16px',
      background: color, border: 'none', borderRadius: 14,
      color: '#fff', fontFamily: T.font, fontSize: 15, fontWeight: 700,
      letterSpacing: -0.2, cursor: 'pointer',
      boxShadow: `0 8px 24px ${color}40`,
    }}>{children}</button>
  );
}

// ─────────────────────────────────────────────────────────────
// 11. SPLASH / WELCOME
// ─────────────────────────────────────────────────────────────
function SplashScreen() {
  return (
    <PhoneShell hideNav>
      {/* Ambient glow */}
      <div style={{
        position: 'absolute', top: '15%', left: '50%', transform: 'translateX(-50%)',
        width: 320, height: 320, borderRadius: '50%',
        background: `radial-gradient(circle, ${T.blue}33 0%, transparent 70%)`,
        filter: 'blur(40px)', pointerEvents: 'none',
      }} />
      <div style={{
        position: 'absolute', bottom: '20%', right: '-10%',
        width: 260, height: 260, borderRadius: '50%',
        background: `radial-gradient(circle, #7C3AED33 0%, transparent 70%)`,
        filter: 'blur(40px)', pointerEvents: 'none',
      }} />

      <div style={{
        position: 'relative', zIndex: 1,
        height: '100%', display: 'flex', flexDirection: 'column',
        padding: '60px 28px 36px',
      }}>
        {/* Logo + Brand */}
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column',
                      alignItems: 'center', justifyContent: 'center', gap: 22 }}>
          <Logo size={96} />
          <div style={{ textAlign: 'center' }}>
            <div style={{ fontFamily: T.font, fontSize: 40, fontWeight: 800,
                          color: T.text, letterSpacing: -1.5, lineHeight: 1 }}>
              DayFlow
            </div>
            <div style={{ marginTop: 12, fontFamily: T.font, fontSize: 15,
                          color: T.textDim, fontWeight: 500, letterSpacing: -0.1,
                          maxWidth: 240, lineHeight: 1.4 }}>
              Organiza tu día.<br />Construye mejores hábitos.
            </div>
          </div>

          {/* Feature pills */}
          <div style={{ marginTop: 8, display: 'flex', gap: 8, flexWrap: 'wrap',
                        justifyContent: 'center' }}>
            {[
              { i: 'check',  l: 'Sin conexión', c: T.health },
              { i: 'shield', l: '100% privado', c: T.blue },
              { i: 'bell',   l: 'Recordatorios', c: T.personal },
            ].map((f, i) => (
              <span key={i} style={{
                display: 'inline-flex', alignItems: 'center', gap: 6,
                padding: '6px 12px', borderRadius: 999,
                background: T.surface, border: `1px solid ${T.border}`,
                color: f.c, fontFamily: T.font, fontSize: 11.5, fontWeight: 600,
              }}>
                <Icon name={f.i} size={12} color={f.c} />
                {f.l}
              </span>
            ))}
          </div>
        </div>

        {/* CTAs */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
          <PrimaryButton>Comenzar</PrimaryButton>
          <button style={{
            width: '100%', padding: '15px',
            background: 'transparent', border: `1.5px solid ${T.borderStrong}`,
            borderRadius: 14, color: T.text,
            fontFamily: T.font, fontSize: 14.5, fontWeight: 600, cursor: 'pointer',
          }}>Ya tengo una cuenta</button>
          <div style={{ marginTop: 4, textAlign: 'center',
                        fontFamily: T.font, fontSize: 11.5, color: T.textMute,
                        lineHeight: 1.4 }}>
            Al continuar aceptas los <span style={{ color: T.blue }}>Términos</span>
            {' '}y la <span style={{ color: T.blue }}>Política de privacidad</span>.
          </div>
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 12. LOGIN
// ─────────────────────────────────────────────────────────────
function LoginScreen() {
  return (
    <PhoneShell hideNav>
      <AuthHeader back />
      <div style={{ padding: '12px 28px 28px' }}>
        <Logo size={48} />
        <div style={{ marginTop: 20, fontFamily: T.font, fontSize: 28,
                      fontWeight: 800, color: T.text, letterSpacing: -0.8, lineHeight: 1.1 }}>
          ¡Hola de nuevo!
        </div>
        <div style={{ marginTop: 6, fontFamily: T.font, fontSize: 14,
                      color: T.textDim, fontWeight: 500 }}>
          Inicia sesión para continuar con tu progreso.
        </div>

        <div style={{ marginTop: 22 }}>
          <TextField label="Correo electrónico"
                     value="juan.quiceno@dayflow.app"
                     icon="user" />
          <TextField label="Contraseña"
                     value="micontraseña"
                     icon="shield"
                     type="password"
                     focused
                     trailing={<span style={{ color: T.textDim,
                                              fontFamily: T.font, fontSize: 12.5,
                                              fontWeight: 600, cursor: 'pointer' }}>Ver</span>} />

          <div style={{ marginTop: 14, display: 'flex',
                        alignItems: 'center', justifyContent: 'space-between' }}>
            <label style={{ display: 'flex', alignItems: 'center', gap: 8,
                            cursor: 'pointer' }}>
              <div style={{ width: 18, height: 18, borderRadius: 5,
                            background: T.blue,
                            display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon name="check" size={12} color="#fff" strokeWidth={2.5} />
              </div>
              <span style={{ fontFamily: T.font, fontSize: 13,
                             color: T.textDim, fontWeight: 500 }}>
                Recuérdame
              </span>
            </label>
            <span style={{ fontFamily: T.font, fontSize: 13,
                           color: T.blue, fontWeight: 600, cursor: 'pointer' }}>
              ¿Olvidaste tu contraseña?
            </span>
          </div>

          <div style={{ marginTop: 24 }}>
            <PrimaryButton>Iniciar sesión</PrimaryButton>
          </div>

          {/* Divider */}
          <div style={{ marginTop: 22, display: 'flex',
                        alignItems: 'center', gap: 12 }}>
            <div style={{ flex: 1, height: 1, background: T.border }} />
            <span style={{ fontFamily: T.font, fontSize: 11.5,
                           color: T.textMute, fontWeight: 600,
                           letterSpacing: 0.6, textTransform: 'uppercase' }}>
              o continúa con
            </span>
            <div style={{ flex: 1, height: 1, background: T.border }} />
          </div>

          {/* Social */}
          <div style={{ marginTop: 16, display: 'grid',
                        gridTemplateColumns: '1fr 1fr', gap: 10 }}>
            <SocialBtn provider="google" />
            <SocialBtn provider="apple" />
          </div>

          {/* Signup hint */}
          <div style={{ marginTop: 28, textAlign: 'center',
                        fontFamily: T.font, fontSize: 13.5, color: T.textDim,
                        fontWeight: 500 }}>
            ¿Aún no tienes cuenta?{' '}
            <span style={{ color: T.blue, fontWeight: 700, cursor: 'pointer' }}>
              Regístrate
            </span>
          </div>
        </div>
      </div>
    </PhoneShell>
  );
}

function SocialBtn({ provider }) {
  const map = {
    google: {
      label: 'Google',
      svg: (
        <svg width="20" height="20" viewBox="0 0 48 48">
          <path fill="#4285F4" d="M44.5 20H24v8.5h11.7C34.4 33 29.7 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3 0 5.7 1.1 7.8 3l6-6C34 5.6 29.3 4 24 4 12.9 4 4 12.9 4 24s8.9 20 20 20 20-8.9 20-20c0-1.3-.1-2.7-.5-4z"/>
          <path fill="#34A853" d="M6.3 14.7l6.6 4.8C14.7 16.1 19 13 24 13c3 0 5.7 1.1 7.8 3l6-6C34 5.6 29.3 4 24 4 16.3 4 9.7 8.4 6.3 14.7z"/>
          <path fill="#FBBC05" d="M24 44c5.2 0 9.9-1.8 13.4-4.7l-6.2-5.2C29.4 35.4 26.8 36 24 36c-5.7 0-10.4-3-12.1-7.5l-6.6 5.1C8.6 39.4 15.6 44 24 44z"/>
          <path fill="#EA4335" d="M44.5 20H24v8.5h11.7c-.7 2.1-2 4-3.7 5.5l6.2 5.2c3.6-3.3 5.8-8.1 5.8-13.7 0-1.3-.1-2.7-.5-4z" opacity="0"/>
        </svg>
      ),
    },
    apple: {
      label: 'Apple',
      svg: (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="#fff">
          <path d="M17.05 12.04c-.03-2.93 2.4-4.35 2.5-4.42-1.36-1.99-3.48-2.26-4.24-2.3-1.81-.18-3.53 1.06-4.45 1.06-.92 0-2.34-1.04-3.84-1.01-1.98.03-3.8 1.15-4.82 2.92-2.05 3.55-.52 8.81 1.48 11.7.98 1.41 2.15 3 3.69 2.94 1.48-.06 2.04-.96 3.83-.96 1.78 0 2.29.96 3.85.93 1.59-.03 2.6-1.44 3.57-2.86 1.13-1.64 1.59-3.23 1.61-3.31-.04-.02-3.1-1.19-3.13-4.7zM14.16 3.43c.82-.99 1.36-2.36 1.22-3.73-1.17.05-2.59.78-3.43 1.76-.76.87-1.42 2.27-1.24 3.61 1.31.1 2.64-.66 3.45-1.64z"/>
        </svg>
      ),
    },
  }[provider];
  return (
    <button style={{
      display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
      padding: '12px', borderRadius: 12,
      background: T.surface, border: `1px solid ${T.border}`,
      color: T.text, fontFamily: T.font, fontSize: 13.5, fontWeight: 600,
      cursor: 'pointer',
    }}>
      {map.svg}
      {map.label}
    </button>
  );
}

// ─────────────────────────────────────────────────────────────
// 13. REGISTER
// ─────────────────────────────────────────────────────────────
function RegisterScreen() {
  return (
    <PhoneShell hideNav>
      <AuthHeader back />
      <div style={{ padding: '12px 28px 28px' }}>
        <Logo size={48} />
        <div style={{ marginTop: 20, fontFamily: T.font, fontSize: 28,
                      fontWeight: 800, color: T.text, letterSpacing: -0.8, lineHeight: 1.1 }}>
          Crea tu cuenta
        </div>
        <div style={{ marginTop: 6, fontFamily: T.font, fontSize: 14,
                      color: T.textDim, fontWeight: 500 }}>
          Comienza a organizar tu día en menos de un minuto.
        </div>

        <div style={{ marginTop: 18 }}>
          <TextField label="Nombre completo" value="Juan David Quiceno" icon="user" />
          <TextField label="Correo electrónico" value="juan.quiceno@dayflow.app" icon="bell" />
          <TextField label="Contraseña" value="micontraseña" icon="shield" type="password" focused />

          {/* Password strength */}
          <div style={{ marginTop: 10, display: 'flex',
                        alignItems: 'center', gap: 10 }}>
            <div style={{ flex: 1, display: 'flex', gap: 4 }}>
              {[T.health, T.health, T.personal, T.surfaceHi].map((c, i) => (
                <div key={i} style={{ flex: 1, height: 4, borderRadius: 2, background: c }} />
              ))}
            </div>
            <span style={{ fontFamily: T.font, fontSize: 11.5,
                           color: T.personal, fontWeight: 700 }}>
              Media
            </span>
          </div>
          <div style={{ marginTop: 8, fontFamily: T.font, fontSize: 11.5,
                        color: T.textMute, fontWeight: 500, lineHeight: 1.4 }}>
            Mínimo 8 caracteres, una mayúscula y un número.
          </div>

          <label style={{ marginTop: 18, display: 'flex',
                          alignItems: 'flex-start', gap: 10, cursor: 'pointer' }}>
            <div style={{ marginTop: 2,
                          width: 18, height: 18, borderRadius: 5,
                          background: T.blue,
                          display: 'flex', alignItems: 'center', justifyContent: 'center',
                          flexShrink: 0 }}>
              <Icon name="check" size={12} color="#fff" strokeWidth={2.5} />
            </div>
            <span style={{ fontFamily: T.font, fontSize: 12.5,
                           color: T.textDim, fontWeight: 500, lineHeight: 1.4 }}>
              Acepto los <span style={{ color: T.blue, fontWeight: 600 }}>Términos de servicio</span>
              {' '}y la <span style={{ color: T.blue, fontWeight: 600 }}>Política de privacidad</span>.
            </span>
          </label>

          <div style={{ marginTop: 22 }}>
            <PrimaryButton>Crear cuenta</PrimaryButton>
          </div>

          <div style={{ marginTop: 22, textAlign: 'center',
                        fontFamily: T.font, fontSize: 13.5, color: T.textDim,
                        fontWeight: 500 }}>
            ¿Ya tienes cuenta?{' '}
            <span style={{ color: T.blue, fontWeight: 700, cursor: 'pointer' }}>
              Inicia sesión
            </span>
          </div>
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 14. FORGOT PASSWORD
// ─────────────────────────────────────────────────────────────
function ForgotPasswordScreen() {
  return (
    <PhoneShell hideNav>
      <AuthHeader back />
      <div style={{ padding: '12px 28px 28px' }}>
        {/* Visual */}
        <div style={{ display: 'flex', justifyContent: 'center', marginTop: 20 }}>
          <div style={{
            width: 96, height: 96, borderRadius: 28,
            background: T.blueSoft,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            border: `1px solid ${T.blue}44`,
          }}>
            <Icon name="shield" size={44} color={T.blue} />
          </div>
        </div>

        <div style={{ marginTop: 22, textAlign: 'center',
                      fontFamily: T.font, fontSize: 24, fontWeight: 800,
                      color: T.text, letterSpacing: -0.6, lineHeight: 1.15 }}>
          Recupera tu acceso
        </div>
        <div style={{ marginTop: 8, textAlign: 'center',
                      fontFamily: T.font, fontSize: 14,
                      color: T.textDim, fontWeight: 500, lineHeight: 1.5,
                      padding: '0 8px' }}>
          Ingresa tu correo y te enviaremos un código de verificación
          para restablecer tu contraseña.
        </div>

        <div style={{ marginTop: 22 }}>
          <TextField label="Correo electrónico"
                     value="juan.quiceno@dayflow.app"
                     icon="bell" focused />

          <div style={{ marginTop: 24 }}>
            <PrimaryButton>Enviar código</PrimaryButton>
          </div>
        </div>

        {/* Verification code preview */}
        <div style={{ marginTop: 28,
                      padding: '16px',
                      background: T.surface, border: `1px solid ${T.border}`,
                      borderRadius: 14 }}>
          <div style={{ fontFamily: T.font, fontSize: 12, fontWeight: 700,
                        color: T.textDim, letterSpacing: 0.4, textTransform: 'uppercase' }}>
            Código de 6 dígitos
          </div>
          <div style={{ marginTop: 10, display: 'flex', gap: 8,
                        justifyContent: 'space-between' }}>
            {['4', '7', '2', '9', '', ''].map((d, i) => (
              <div key={i} style={{
                flex: 1, aspectRatio: '1 / 1',
                background: T.surface2,
                border: `1.5px solid ${d ? T.blue : T.border}`,
                borderRadius: 10,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontFamily: T.font, fontSize: 22, fontWeight: 700, color: T.text,
              }}>{d}</div>
            ))}
          </div>
          <div style={{ marginTop: 12, textAlign: 'center',
                        fontFamily: T.font, fontSize: 12.5,
                        color: T.textDim, fontWeight: 500 }}>
            Reenviar en <span style={{ color: T.text, fontWeight: 700 }}>00:42</span>
          </div>
        </div>

        <div style={{ marginTop: 24, textAlign: 'center',
                      fontFamily: T.font, fontSize: 13.5, color: T.textDim,
                      fontWeight: 500 }}>
          ¿Recordaste tu contraseña?{' '}
          <span style={{ color: T.blue, fontWeight: 700, cursor: 'pointer' }}>
            Volver a iniciar sesión
          </span>
        </div>
      </div>
    </PhoneShell>
  );
}

// ─────────────────────────────────────────────────────────────
// 15. MÁS (More) — 5th tab in the bottom nav
// ─────────────────────────────────────────────────────────────
function MasScreen() {
  const groups = [
    {
      title: 'Cuenta',
      items: [
        { i: 'user',    c: T.blue,    l: 'Mi perfil',          s: 'Juan David Quiceno' },
        { i: 'trophy',  c: '#F472B6', l: 'Logros',             s: '4 de 12 conseguidos', badge: '+2' },
        { i: 'bell',    c: T.personal, l: 'Notificaciones',    s: 'Activadas · 15 min antes' },
      ],
    },
    {
      title: 'Personalización',
      items: [
        { i: 'palette', c: '#A78BFA', l: 'Apariencia',         s: 'Oscuro · Azul', toggle: true },
        { i: 'tag',     c: T.health,  l: 'Categorías',         s: '3 categorías' },
        { i: 'repeat',  c: '#38BDF8', l: 'Hábitos recurrentes', s: 'Gestionar plantillas' },
      ],
    },
    {
      title: 'Datos y privacidad',
      items: [
        { i: 'shield',  c: T.health,  l: 'Privacidad',         s: 'Todo se guarda local' },
        { i: 'book',    c: T.academic, l: 'Exportar mis datos', s: 'CSV o JSON' },
        { i: 'trash',   c: T.danger,  l: 'Borrar historial',   s: 'No reversible' },
      ],
    },
    {
      title: 'Soporte',
      items: [
        { i: 'help',    c: T.textDim, l: 'Centro de ayuda',    s: 'Preguntas frecuentes' },
        { i: 'sparkle', c: '#FBBF24', l: 'Califica DayFlow',   s: 'Cuéntanos qué piensas' },
        { i: 'book',    c: T.textDim, l: 'Acerca de',          s: 'v 1.0.0 · DayFlow' },
      ],
    },
  ];

  return (
    <PhoneShell activeTab="more">
      <AppBar left={null} title="Más" right="settings" />

      <div style={{ padding: '4px 20px 24px' }}>
        {/* Profile mini card */}
        <div style={{
          background: `linear-gradient(135deg, ${T.surface} 0%, ${T.surface2} 100%)`,
          border: `1px solid ${T.border}`,
          borderRadius: 18, padding: '16px',
          display: 'flex', alignItems: 'center', gap: 14,
        }}>
          <div style={{
            width: 54, height: 54, borderRadius: 27,
            background: `linear-gradient(135deg, ${T.blue}, #A78BFA)`,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            color: '#fff', fontFamily: T.font, fontSize: 20, fontWeight: 700,
            letterSpacing: -0.4, flexShrink: 0,
          }}>JD</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ fontFamily: T.font, fontSize: 16, fontWeight: 700,
                          color: T.text, letterSpacing: -0.2 }}>
              Juan David Quiceno
            </div>
            <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 12.5,
                          color: T.textDim, fontWeight: 500,
                          whiteSpace: 'nowrap', overflow: 'hidden',
                          textOverflow: 'ellipsis' }}>
              juan.quiceno@dayflow.app
            </div>
            <div style={{ marginTop: 6, display: 'flex', gap: 6, flexWrap: 'wrap' }}>
              <span style={{
                display: 'inline-flex', alignItems: 'center', gap: 4,
                padding: '2px 8px', borderRadius: 999,
                background: T.personal + '22', color: T.personal,
                fontFamily: T.font, fontSize: 10.5, fontWeight: 700,
              }}>
                <Icon name="flame" size={10} color={T.personal} /> Racha 12
              </span>
              <span style={{
                display: 'inline-flex', alignItems: 'center', gap: 4,
                padding: '2px 8px', borderRadius: 999,
                background: T.blueSoft, color: T.blue,
                fontFamily: T.font, fontSize: 10.5, fontWeight: 700,
              }}>Plan Free</span>
            </div>
          </div>
          <Icon name="chevron-right" size={18} color={T.textDim} />
        </div>

        {/* Upgrade banner */}
        <div style={{
          marginTop: 14,
          background: `linear-gradient(135deg, #7C3AED 0%, ${T.blue} 100%)`,
          borderRadius: 16, padding: '14px 16px',
          display: 'flex', alignItems: 'center', gap: 12,
          color: '#fff',
          boxShadow: `0 10px 28px #7C3AED50`,
        }}>
          <div style={{
            width: 38, height: 38, borderRadius: 12,
            background: 'rgba(255,255,255,0.22)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>
            <Icon name="sparkle" size={20} color="#fff" />
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ fontFamily: T.font, fontSize: 14, fontWeight: 700,
                          letterSpacing: -0.2 }}>Prueba DayFlow Pro</div>
            <div style={{ marginTop: 2, fontFamily: T.font, fontSize: 11.5,
                          opacity: 0.92 }}>Estadísticas avanzadas y temas exclusivos</div>
          </div>
          <Icon name="chevron-right" size={18} color="#fff" />
        </div>

        {/* Groups */}
        {groups.map((g, gi) => (
          <div key={gi} style={{ marginTop: 24 }}>
            <div style={{
              fontFamily: T.font, fontSize: 12, fontWeight: 700,
              color: T.textDim, letterSpacing: 0.6, textTransform: 'uppercase',
              marginBottom: 10, paddingLeft: 4,
            }}>{g.title}</div>

            <div style={{ background: T.surface, borderRadius: 16,
                          border: `1px solid ${T.border}`, overflow: 'hidden' }}>
              {g.items.map((it, i) => (
                <div key={i} style={{
                  display: 'flex', alignItems: 'center', gap: 14,
                  padding: '14px 16px',
                  borderBottom: i < g.items.length - 1 ? `1px solid ${T.border}` : 'none',
                }}>
                  <div style={{
                    width: 36, height: 36, borderRadius: 10,
                    background: `${it.c}22`, color: it.c,
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    flexShrink: 0,
                  }}>
                    <Icon name={it.i} size={18} color={it.c} />
                  </div>
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ fontFamily: T.font, fontSize: 14.5, fontWeight: 600,
                                  color: T.text, letterSpacing: -0.2 }}>{it.l}</div>
                    <div style={{ marginTop: 1, fontFamily: T.font, fontSize: 11.5,
                                  color: T.textMute, fontWeight: 500,
                                  whiteSpace: 'nowrap', overflow: 'hidden',
                                  textOverflow: 'ellipsis' }}>{it.s}</div>
                  </div>
                  {it.badge && (
                    <span style={{
                      padding: '2px 8px', borderRadius: 999, background: T.blue,
                      color: '#fff', fontFamily: T.font, fontSize: 10.5, fontWeight: 700,
                    }}>{it.badge}</span>
                  )}
                  {it.toggle ? (
                    <div style={{
                      width: 38, height: 22, borderRadius: 11, background: T.blue,
                      position: 'relative', flexShrink: 0,
                    }}>
                      <div style={{
                        position: 'absolute', top: 2, right: 2,
                        width: 18, height: 18, borderRadius: 9, background: '#fff',
                      }} />
                    </div>
                  ) : (
                    <Icon name="chevron-right" size={16} color={T.textMute} />
                  )}
                </div>
              ))}
            </div>
          </div>
        ))}

        {/* Logout */}
        <button style={{
          width: '100%', marginTop: 22,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          gap: 10, padding: '14px',
          background: 'transparent', border: `1px solid ${T.borderStrong}`,
          borderRadius: 14, color: T.danger,
          fontFamily: T.font, fontSize: 14, fontWeight: 600, cursor: 'pointer',
        }}>
          <Icon name="logout" size={18} color={T.danger} />
          Cerrar sesión
        </button>

        <div style={{ marginTop: 16, textAlign: 'center',
                      fontFamily: T.font, fontSize: 11, color: T.textMute,
                      fontWeight: 500 }}>
          DayFlow · v1.0.0 · Hecho con Flutter
        </div>
      </div>
    </PhoneShell>
  );
}

Object.assign(window, {
  SplashScreen, LoginScreen, RegisterScreen,
  ForgotPasswordScreen, MasScreen,
});
