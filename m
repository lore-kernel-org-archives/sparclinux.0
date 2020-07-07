From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Tue, 07 Jul 2020 17:24:36 +0000
Subject: [PATCH][next] sparc: Use fallthrough pseudo-keyword
Message-Id: <20200707172436.GA27273@embeddedor>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highligh=
t=FAllthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/sparc/kernel/auxio_64.c  |    1 -
 arch/sparc/kernel/central.c   |    2 +-
 arch/sparc/kernel/kgdb_32.c   |    2 +-
 arch/sparc/kernel/kgdb_64.c   |    2 +-
 arch/sparc/kernel/pcr.c       |    2 +-
 arch/sparc/kernel/prom_32.c   |    2 +-
 arch/sparc/kernel/signal32.c  |    4 ++--
 arch/sparc/kernel/signal_32.c |    4 ++--
 arch/sparc/kernel/signal_64.c |    4 ++--
 arch/sparc/math-emu/math_32.c |    8 ++++----
 10 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 4843f48bfe85..774a82b0c649 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -87,7 +87,6 @@ void auxio_set_lte(int on)
 		__auxio_sbus_set_lte(on);
 		break;
 	case AUXIO_TYPE_EBUS:
-		/* FALL-THROUGH */
 	default:
 		break;
 	}
diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index bfae98ab8638..23f8838dd96e 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -55,7 +55,7 @@ static int clock_board_calc_nslots(struct clock_board *p)
 			else
 				return 5;
 		}
-		/* Fallthrough */
+		fallthrough;
 	default:
 		return 4;
 	}
diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 7580775a14b9..58ad3f7de1fb 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -122,7 +122,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo,=
 int err_code,
 			linux_regs->pc =3D addr;
 			linux_regs->npc =3D addr + 4;
 		}
-		/* fall through */
+		fallthrough;
=20
 	case 'D':
 	case 'k':
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index 5d6c2d287e85..177746ae2c81 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -148,7 +148,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo,=
 int err_code,
 			linux_regs->tpc =3D addr;
 			linux_regs->tnpc =3D addr + 4;
 		}
-		/* fall through */
+		fallthrough;
=20
 	case 'D':
 	case 'k':
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index c0886b400dad..2a12c86af956 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -359,7 +359,7 @@ int __init pcr_arch_init(void)
 		 * counter overflow interrupt so we can't make use of
 		 * their hardware currently.
 		 */
-		/* fallthrough */
+		fallthrough;
 	default:
 		err =3D -ENODEV;
 		goto out_unregister;
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index da8902295c8c..3df960c137f7 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -224,7 +224,7 @@ void __init of_console_init(void)
=20
 		case PROMDEV_TTYB:
 			skip =3D 1;
-			/* FALLTHRU */
+			fallthrough;
=20
 		case PROMDEV_TTYA:
 			type =3D "serial";
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e2c6f0abda00..e9695a06492f 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -646,7 +646,7 @@ static inline void syscall_restart32(unsigned long orig=
_i0, struct pt_regs *regs
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] =3D orig_i0;
 		regs->tpc -=3D 4;
@@ -686,7 +686,7 @@ void do_signal32(struct pt_regs * regs)
 				regs->tpc -=3D 4;
 				regs->tnpc -=3D 4;
 				pt_regs_clear_syscall(regs);
-				/* fall through */
+				fallthrough;
 			case ERESTART_RESTARTBLOCK:
 				regs->u_regs[UREG_G1] =3D __NR_restart_syscall;
 				regs->tpc -=3D 4;
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 3b005b6c3e0f..e08d294d63e4 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -441,7 +441,7 @@ static inline void syscall_restart(unsigned long orig_i=
0, struct pt_regs *regs,
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] =3D orig_i0;
 		regs->pc -=3D 4;
@@ -507,7 +507,7 @@ static void do_signal(struct pt_regs *regs, unsigned lo=
ng orig_i0)
 				regs->pc -=3D 4;
 				regs->npc -=3D 4;
 				pt_regs_clear_syscall(regs);
-				/* fall through */
+				fallthrough;
 			case ERESTART_RESTARTBLOCK:
 				regs->u_regs[UREG_G1] =3D __NR_restart_syscall;
 				regs->pc -=3D 4;
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 6937339a272c..255264bcb46a 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -461,7 +461,7 @@ static inline void syscall_restart(unsigned long orig_i=
0, struct pt_regs *regs,
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] =3D orig_i0;
 		regs->tpc -=3D 4;
@@ -532,7 +532,7 @@ static void do_signal(struct pt_regs *regs, unsigned lo=
ng orig_i0)
 				regs->tpc -=3D 4;
 				regs->tnpc -=3D 4;
 				pt_regs_clear_syscall(regs);
-				/* fall through */
+				fallthrough;
 			case ERESTART_RESTARTBLOCK:
 				regs->u_regs[UREG_G1] =3D __NR_restart_syscall;
 				regs->tpc -=3D 4;
diff --git a/arch/sparc/math-emu/math_32.c b/arch/sparc/math-emu/math_32.c
index 72e560ef4a09..d5beec856146 100644
--- a/arch/sparc/math-emu/math_32.c
+++ b/arch/sparc/math-emu/math_32.c
@@ -359,7 +359,7 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr=
, unsigned long *fregs)
 			*pfsr |=3D (6 << 14);
 			return 0;			/* simulate invalid_fp_register exception */
 		}
-	/* fall through */
+		fallthrough;
 	case 2:
 		if (freg & 1) {				/* doublewords must have bit 5 zeroed */
 			*pfsr |=3D (6 << 14);
@@ -380,7 +380,7 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr=
, unsigned long *fregs)
 			*pfsr |=3D (6 << 14);
 			return 0;			/* simulate invalid_fp_register exception */
 		}
-	/* fall through */
+		fallthrough;
 	case 2:
 		if (freg & 1) {				/* doublewords must have bit 5 zeroed */
 			*pfsr |=3D (6 << 14);
@@ -408,13 +408,13 @@ static int do_one_mathemu(u32 insn, unsigned long *pf=
sr, unsigned long *fregs)
 			*pfsr |=3D (6 << 14);
 			return 0;			/* simulate invalid_fp_register exception */
 		}
-	/* fall through */
+		fallthrough;
 	case 2:
 		if (freg & 1) {				/* doublewords must have bit 5 zeroed */
 			*pfsr |=3D (6 << 14);
 			return 0;
 		}
-	/* fall through */
+		fallthrough;
 	case 1:
 		rd =3D (void *)&fregs[freg];
 		break;
