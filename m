From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Jan 2016 11:32:30 +0000
Subject: Re: using ptrace to cancel a syscall on sparc
Message-Id: <20160118113230.GA14447@vapier.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
List-Id: <sparclinux.vger.kernel.org>
References: <20151220054754.GZ11489@vapier.lan>
In-Reply-To: <20151220054754.GZ11489@vapier.lan>
To: sparclinux@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21 Dec 2015 02:31, Dmitry V. Levin wrote:
> On Sun, Dec 20, 2015 at 12:47:54AM -0500, Mike Frysinger wrote:
> > i've been playing with ptrace on sparc and trying to use it to watch and
> > cancel specific syscalls.  i have this working for other arches already.
> [...]
> > i'm having trouble with canceling of the syscall itself.  seems like
> > no matter what i stuff into o0, the kernel executes the unlink.  i've
> > tried tracing arch/sparc/kernel/syscalls.S and kernel/head_64.S, the
> > the entry is linux_sparc_syscall32 which calls linux_syscall_trace32,
> > but it seems like the o0 stuff doesn't seem to work for me.  my sparc
> > asm foo isn't strong enough to figure out what's going wrong :/.
>=20
> Yes, sparc is odd in this respect: whatever you write to u_regs[] on
> entering syscall, it doesn't affect syscall number or syscall arguments.

looks like the bug is in arch/sparc/kernel/syscalls.S:linux_syscall_trace32
(and linux_syscall_trace).  they don't reload the args from the pt_regs
struct after calling syscall_trace_enter.  i put in a small hack:
linux_syscall_trace32:
	call	syscall_trace_enter
	 add	%sp, PTREGS_OFF, %o0
	brnz,pn	%o0, 3f
	 mov	-ENOSYS, %o0
+
+	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
+	cmp	%g1, NR_syscalls
=3D	bgeu,pn	%xcc, 3f
+	 mov	-ENOSYS, %o0
+
	srl	%i0, 0, %o0
	srl	%i4, 0, %o4
=2E..

it's enough for my use case (cancel the call), but it's not entirely correc=
t.
i think it needs to re-initialize %l7 with the final syscall pointer via the
syscall table, and it needs to reload PT_V9_I{0..5}.  i have no idea which
regs need stuffing though, especially in light of the %l7 optimization.  and
i'm not familiar at all with the apparent parallelism via IEU0/IEU1 groups.
so i won't bother with trying to write a full patch.  hopefully sparc guys
will notice & post a fix ;).

i'm attaching my simple test in case it helps.  just do:
  $ gcc ptrace-test.c && ./a.out
the logging output should indicate when things are passing.
-mike

--9amGYk9869ThD9tj
Content-Type: text/x-c; charset=utf-8
Content-Disposition: attachment; filename="ptrace-test.c"

#define _GNU_SOURCE

#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <asm/ptrace.h>

#define U_REG_G1 0
#define U_REG_O0 7

static pid_t trace_pid;

static long _do_ptrace(enum __ptrace_request request, const char *srequest, void *addr, void *data)
{
	long ret;
 try_again:
	errno = 0;
	ret = ptrace(request, trace_pid, addr, data);
	if (ret == -1) {
		/* Child hasn't gotten to the next marker yet ? */
		if (errno == ESRCH) {
			int status;
			if (waitpid(trace_pid, &status, 0) == -1) {
				/* nah, it's dead ... should we whine though ? */
				_exit(0);
			}
			sched_yield();
			goto try_again;
		} else if (!errno)
			if (request == PTRACE_PEEKDATA ||
			    request == PTRACE_PEEKTEXT ||
			    request == PTRACE_PEEKUSER)
				return ret;

		err(1, "do_ptrace: ptrace(%s, ..., %p, %p)", srequest, addr, data);
	}
	return ret;
}
#define do_ptrace(request, addr, data) _do_ptrace(request, #request, addr, data)

static void trace_child_signal(int signo, siginfo_t *info, void *context)
{
#if 0
	warnx("got sig %s(%i): code:%s(%i) status:%s(%i)",
		strsignal(signo), signo,
		"---", info->si_code,
		strsignal(info->si_status), info->si_status);
#endif

	switch (info->si_code) {
		case CLD_DUMPED:
		case CLD_KILLED:
			_exit(128 + info->si_status);

		case CLD_EXITED:
			_exit(info->si_status);

		case CLD_TRAPPED:
			switch (info->si_status) {
				case SIGSTOP:
					kill(trace_pid, SIGCONT);
				case SIGTRAP:
				case SIGCONT:
					return;
			}

			/* For whatever signal the child caught, let's ignore it and
			 * continue on.  If it aborted, segfaulted, whatever, that's
			 * its problem, not ours, so don't whine about it.  We just
			 * have to be sure to bubble it back up.  #265072
			 */
			do_ptrace(PTRACE_CONT, NULL, (void *)(long)info->si_status);
			return;
	}

	errx(1, "unhandled signal case");
}

static const char *lookup_syscall(long nr)
{
	switch (nr) {
#define X(n) case SYS_##n: return #n;
	X(access)
	X(brk)
	X(close)
	X(creat)
	X(dup)
	X(exit)
	X(exit_group)
	X(fstat64)
	X(mmap)
	X(mprotect)
	X(munmap)
	X(open)
	X(read)
	X(uname)
	X(unlink)
	X(write)
#undef X
	}
	return "";
}

void child_main(void)
{
	char test_file[] = ".test.flag";
	char msg[] = "child: you should see two of these\n";
	int fd = dup(2);

	unlink(test_file);
	write(fd, msg, sizeof(msg));

	/* Marker for the parent to watch. */
	errno = 0;
	close(12345);
	fprintf(stderr, "child: close marker (should be EPERM): %m\n");
	errno = 0;
	close(fd);
	fprintf(stderr, "child: real close (should be EPERM): %m\n");
	errno = 0;
	write(fd, msg, sizeof(msg));
	fprintf(stderr, "child: write (should be success): %m\n");
	errno = 0;
	creat(test_file, 0660);
	fprintf(stderr, "child: creat (should be EPERM): %m\n");
	errno = 0;
	access(test_file, F_OK);
	fprintf(stderr, "child: access (should be ENOENT): %m\n");

	unlink(test_file);
	exit(0);
}

static void parent_main(void)
{
	int status;
	struct pt_regs regs;
	long nr, arg1;

	/* Wait for the child to exec. */
	while (1) {
		do_ptrace(PTRACE_SYSCALL, NULL, NULL);
		waitpid(trace_pid, &status, 0);

		unsigned event = ((unsigned)status >> 16);
		if (event == PTRACE_EVENT_EXEC) {
			warnx("parent: hit exec!");
			break;
		} else
			warnx("parent: waiting for exec; status: %#x", status);
	}

	/* Main loop. */
	bool saw_close = false;
	bool before_syscall = false;
	bool fake_syscall_ret = false;
	while (1) {
		do_ptrace(PTRACE_SYSCALL, NULL, NULL);
		waitpid(trace_pid, &status, 0);

		do_ptrace(PTRACE_GETREGS, &regs, NULL);
		nr = regs.u_regs[U_REG_G1];
		arg1 = regs.u_regs[U_REG_O0];
		if (before_syscall) {
			warnx("parent: NR:%3li %s", nr, lookup_syscall(nr));
			/* Once the child hits the marker, deny all close & creat calls */
			if (nr == __NR_close || nr == __NR_creat) {
				if (saw_close || arg1 == 12345) {
					saw_close = true;
					warnx("parent: setting NR to -1");
					regs.u_regs[U_REG_G1] = -1;
					do_ptrace(PTRACE_SETREGS, &regs, NULL);
					fake_syscall_ret = true;
				}
			}
		} else if (fake_syscall_ret) {
			warnx("parent: forcing EPERM");
			regs.psr |= PSR_C;
			regs.u_regs[U_REG_O0] = EPERM;
			do_ptrace(PTRACE_SETREGS, &regs, NULL);
			fake_syscall_ret = false;
		}

		before_syscall = !before_syscall;
	}
}

int main(int argc, char *argv[])
{
	struct sigaction sa, old_sa;

	/* Child will re-exec us so the ptrace is clean for the parent. */
	if (argc > 1)
		child_main();

	/* Set up signal handler to watch for child events. */
	sa.sa_flags = SA_RESTART | SA_SIGINFO;
	sa.sa_sigaction = trace_child_signal;
	sigaction(SIGCHLD, &sa, &old_sa);

	/* Fork a child and have the parent do some early ptrace init. */
	trace_pid = fork();
	if (trace_pid == -1) {
		err(1, "fork() failed");
	} else if (trace_pid) {
		warn("parent waiting for child (pid=%i) to signal", trace_pid);
		waitpid(trace_pid, NULL, 0);
		do_ptrace(PTRACE_SETOPTIONS, NULL,
			(void *)(PTRACE_O_TRACESYSGOOD | PTRACE_O_TRACEEXEC));
		parent_main();
		errx(1, "child should have quit, as should we");
	}

	/* Have the child set itself up for tracing before execing again. */
	warnx("child setting up ...");
	sigaction(SIGCHLD, &old_sa, NULL);
	do_ptrace(PTRACE_TRACEME, NULL, NULL);
	kill(getpid(), SIGSTOP);
	execl(argv[0], argv[0], "--child", NULL);

	return 0;
}

--9amGYk9869ThD9tj--

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnM1OAAoJEEFjO5/oN/WBRYcP/RqAqqur4UkuV0vOi13JB6CX
vk0fYUh+nEZLTSniX/857TkD97RJInQlYLTwirUluP1kJh6vZkoZJXqrw2pDKAgM
AmVCYshRoquM2xV9nJFito3n06VqmsVgWyGFtSwvDuHAc/x7tPJEhmVJsFxp/rEQ
D6q2OES9t6JXQd65iqsGjvL64t8Kmv03fazSFIjeStg4Qi4sUEZAg02DVnQYRBmm
0Eisr7xxmiOU0DhT/DvIDnjvM4VNMTOrrzneCODqzlT82VNNhg0f4XgjM9zzrWSu
M2aH+bsgJQEV0beBrawtpLKm56YxUOmaUWlfjvg7nCtDPJe/kyKVU8dWqnOhlbhh
Fe+P2qcCxSb4gVgbuGf+QZGL/qr7+Tjaw/2cyhDGOM/FGnh7/pPlbQKbKeKp351B
d509W5ZV1Sv5o6fHsGdVOVNtS3QEHVdC4mhKWv++tTf6atAoPQnnBq9MreWnJY4q
fx22i7/zHeMSgws738iDwGuZFPTnn3RA5DkUnuQy9B0DyE5JxzDjm7KmTCjVqRgU
jHgC/G42ax1g5UvJEeOMmNHA4QLHxQ+POdOI6SS480+2W7SbFBYjWgG9ttc5bqHG
Z+rgZIkN78lNtH4cznAIrGtFK107hqu2kQeoz8WQK9krFoeoWM00k1bv1iQYBzJK
rLAMIBASSYdju30cH+77
=66NG
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
