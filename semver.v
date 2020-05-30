module vsemver

pub enum Stage {
	alpha
	beta
	rc
	release
}

pub struct SemVer {
pub mut:
	major int = 0
	minor int = 1
	patch int = 0
	stage Stage = .release
	build string = ''
}

// Initialise
fn init() {
}

// Constructor
pub fn create_semver(major, minor, patch int) SemVer {
	return SemVer{
		major: major
		minor: minor
		patch: patch
	}
}

// Set release
pub fn (mut sv SemVer) set_release(rel Stage) {
	sv.stage = rel
}

// Get release
pub fn (sv &SemVer) get_release() Stage {
	return sv.stage
}

// Set build
pub fn (mut sv SemVer) set_build(build string) {
	sv.build = build
}

// Get build
pub fn (sv &SemVer) get_build() string {
	return sv.build
}

// Get string
pub fn (sv &SemVer) str() string {
	mut semver := sv.major.str()
	semver += '.'
	semver += sv.minor.str()
	semver += '.'
	semver += sv.patch.str()
	//
	if sv.stage != .release {
		semver += '-'
		match sv.stage {
			.alpha {
				semver += 'alpha'
			}
			.beta {
				semver += 'beta'
			}
			.rc {
				semver += 'rc'
			}
			else {
				// TODO: Handle better
				assert false
			}
		}
	}
	//
	if sv.build.len != 0 {
		semver += '+'
		semver += sv.build
	}
	//
	return semver
}

pub fn (sv &SemVer) is_greater(other SemVer) bool {
	if sv.is_equal(other) {
		return false
	}
	//
	res := SemVer{
		major: sv.major - other.major
		minor: sv.minor - other.minor
		patch: sv.patch - other.patch
	}
	return (res.major > 0) || (res.major == 0 && res.minor > 0) || (res.major == 0 && res.minor >
		0 && res.patch > 0)
}

pub fn (sv &SemVer) is_equal(other SemVer) bool {
	return (sv.major == other.major) && (sv.minor == other.minor) && (sv.patch == other.patch)
}
