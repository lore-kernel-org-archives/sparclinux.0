From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 02 Oct 2007 17:28:08 +0000
Subject: Bug: semctl failures on sparc64
Message-Id: <1191346088.3553.151.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-Na1UmKqw/wlI7lSJUpdm"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-Na1UmKqw/wlI7lSJUpdm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been trying to track down why postgresql has been failing to run
its tests when built for sparc64, and working with Tom Lane, we've
generated an independent test case showing that the failure seems to be
in the kernel.

The test case is attached:

bash-3.2# gcc -m32 -o semtest32 semtest.c 
bash-3.2# ./semtest32 
created semaphores with id 32769
bash-3.2# gcc -m64 -o semtest64 semtest.c 
bash-3.2# ./semtest64
semctl: Invalid argument

Thanks in advance,

~spot

--=-Na1UmKqw/wlI7lSJUpdm
Content-Disposition: attachment; filename=semtest.c
Content-Type: text/x-csrc; name=semtest.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*-------------------------------------------------------------------------
 *
 * sysv_sema.c
 *	  Implement PGSemaphores using SysV semaphore facilities
 *
 *
 * Portions Copyright (c) 1996-2007, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * IDENTIFICATION
 *	  $PostgreSQL: pgsql/src/backend/port/sysv_sema.c,v 1.21 2007/01/05 22:19:35 momjian Exp $
 *
 *-------------------------------------------------------------------------
 */
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <unistd.h>
#include <sys/file.h>
#include <sys/ipc.h>
#include <sys/sem.h>


#ifndef HAVE_UNION_SEMUN
union semun
{
	int			val;
	struct semid_ds *buf;
	unsigned short *array;
};
#endif

typedef key_t IpcSemaphoreKey;	/* semaphore key passed to semget(2) */
typedef int IpcSemaphoreId;		/* semaphore ID returned by semget(2) */

/*
 * SEMAS_PER_SET is the number of useful semaphores in each semaphore set
 * we allocate.  It must be *less than* your kernel's SEMMSL (max semaphores
 * per set) parameter, which is often around 25.  (Less than, because we
 * allocate one extra sema in each set for identification purposes.)
 */
#define SEMAS_PER_SET	16

#define IPCProtection	(0600)	/* access/modify by user only */

#define PGSemaMagic		537		/* must be less than SEMVMX */


static IpcSemaphoreKey nextSemaKey = 42000;		/* next key to try using */


static IpcSemaphoreId InternalIpcSemaphoreCreate(IpcSemaphoreKey semKey,
						   int numSems);
static void IpcSemaphoreInitialize(IpcSemaphoreId semId, int semNum,
					   int value);
static void IpcSemaphoreKill(IpcSemaphoreId semId);
static int	IpcSemaphoreGetValue(IpcSemaphoreId semId, int semNum);
static pid_t IpcSemaphoreGetLastPID(IpcSemaphoreId semId, int semNum);
static IpcSemaphoreId IpcSemaphoreCreate(int numSems);


/*
 * InternalIpcSemaphoreCreate
 *
 * Attempt to create a new semaphore set with the specified key.
 * Will fail (return -1) if such a set already exists.
 *
 * If we fail with a failure code other than collision-with-existing-set,
 * print out an error and abort.  Other types of errors suggest nonrecoverable
 * problems.
 */
static IpcSemaphoreId
InternalIpcSemaphoreCreate(IpcSemaphoreKey semKey, int numSems)
{
	int			semId;

	semId = semget(semKey, numSems, IPC_CREAT | IPC_EXCL | IPCProtection);

	if (semId < 0)
	{
		/*
		 * Fail quietly if error indicates a collision with existing set. One
		 * would expect EEXIST, given that we said IPC_EXCL, but perhaps we
		 * could get a permission violation instead?  Also, EIDRM might occur
		 * if an old set is slated for destruction but not gone yet.
		 */
		if (errno == EEXIST || errno == EACCES
#ifdef EIDRM
			|| errno == EIDRM
#endif
			)
			return -1;

		/*
		 * Else complain and abort
		 */
		perror("semget");
		exit(1);
	}

	return semId;
}

/*
 * Initialize a semaphore to the specified value.
 */
static void
IpcSemaphoreInitialize(IpcSemaphoreId semId, int semNum, int value)
{
	union semun semun;

	semun.val = value;
	if (semctl(semId, semNum, SETVAL, semun) < 0)
	{
		perror("semctl");
		exit(1);
	}
}

/*
 * IpcSemaphoreKill(semId)	- removes a semaphore set
 */
static void
IpcSemaphoreKill(IpcSemaphoreId semId)
{
	union semun semun;

	semun.val = 0;				/* unused, but keep compiler quiet */

	if (semctl(semId, 0, IPC_RMID, semun) < 0)
		perror("semctl(RMID)");
}

/* Get the current value (semval) of the semaphore */
static int
IpcSemaphoreGetValue(IpcSemaphoreId semId, int semNum)
{
	union semun dummy;			/* for Solaris */

	dummy.val = 0;				/* unused */

	return semctl(semId, semNum, GETVAL, dummy);
}

/* Get the PID of the last process to do semop() on the semaphore */
static pid_t
IpcSemaphoreGetLastPID(IpcSemaphoreId semId, int semNum)
{
	union semun dummy;			/* for Solaris */

	dummy.val = 0;				/* unused */

	return semctl(semId, semNum, GETPID, dummy);
}


/*
 * Create a semaphore set with the given number of useful semaphores
 * (an additional sema is actually allocated to serve as identifier).
 * Dead Postgres sema sets are recycled if found, but we do not fail
 * upon collision with non-Postgres sema sets.
 *
 * The idea here is to detect and re-use keys that may have been assigned
 * by a crashed postmaster or backend.
 */
static IpcSemaphoreId
IpcSemaphoreCreate(int numSems)
{
	IpcSemaphoreId semId;
	union semun semun;

	/* Loop till we find a free IPC key */
	for (nextSemaKey++;; nextSemaKey++)
	{
		pid_t		creatorPID;

		/* Try to create new semaphore set */
		semId = InternalIpcSemaphoreCreate(nextSemaKey, numSems + 1);
		if (semId >= 0)
			break;				/* successful create */

		/* See if it looks to be leftover from a dead Postgres process */
		semId = semget(nextSemaKey, numSems + 1, 0);
		if (semId < 0)
			continue;			/* failed: must be some other app's */
		if (IpcSemaphoreGetValue(semId, numSems) != PGSemaMagic)
			continue;			/* sema belongs to a non-Postgres app */

		/*
		 * If the creator PID is my own PID or does not belong to any extant
		 * process, it's safe to zap it.
		 */
		creatorPID = IpcSemaphoreGetLastPID(semId, numSems);
		if (creatorPID <= 0)
			continue;			/* oops, GETPID failed */
		if (creatorPID != getpid())
		{
			if (kill(creatorPID, 0) == 0 || errno != ESRCH)
				continue;		/* sema belongs to a live process */
		}

		/*
		 * The sema set appears to be from a dead Postgres process, or from a
		 * previous cycle of life in this same process.  Zap it, if possible.
		 * This probably shouldn't fail, but if it does, assume the sema set
		 * belongs to someone else after all, and continue quietly.
		 */
		semun.val = 0;			/* unused, but keep compiler quiet */
		if (semctl(semId, 0, IPC_RMID, semun) < 0)
			continue;

		/*
		 * Now try again to create the sema set.
		 */
		semId = InternalIpcSemaphoreCreate(nextSemaKey, numSems + 1);
		if (semId >= 0)
			break;				/* successful create */

		/*
		 * Can only get here if some other process managed to create the same
		 * sema key before we did.	Let him have that one, loop around to try
		 * next key.
		 */
	}

	IpcSemaphoreInitialize(semId, numSems, PGSemaMagic - 1);

	return semId;
}


int
main()
{
	IpcSemaphoreId	semid;

	semid = IpcSemaphoreCreate(16);

	printf("created semaphores with id %d\n", semid);

	IpcSemaphoreKill(semid);

	return 0;
}

--=-Na1UmKqw/wlI7lSJUpdm--

