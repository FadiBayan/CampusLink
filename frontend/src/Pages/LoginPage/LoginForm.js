import React, { useState, useEffect } from "react";
import PasswordInput from "./PasswordInput";
import { tryLogin } from "../../auth-api";
import { Link, useNavigate } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import "../../static/LoginPage/Login.css"; // ✅ Import custom CSS for extra styling

const LoginForm = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const [role, setRole] = useState("student");
  const navigate = useNavigate();

  useEffect(() => {
    document.body.classList.add("login-page");
    return () => document.body.classList.remove("login-page");
  }, []);

  const handleRoleSelection = (event) => {
    setRole(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setMessage("");
    setError("");

    try {
      const responseMessage = await tryLogin(email, password);

      if (typeof responseMessage === "object") {
        setError(responseMessage.message || "An unexpected error occurred.");
      } else {
        setMessage(responseMessage);
        localStorage.setItem("userRole", role);
        role === "student" ? navigate("/student") : navigate("/home");
      }
    } catch (err) {
      setError(err.message || "Login failed. Please check your credentials.");
    }
  };

  return (
    <div className="container-fluid vh-100">
      <div className="row h-100 m-0">
        {/* LEFT - INFO SECTION */}
        
        <div className="col-6 d-flex align-items-center justify-content-center gradient-bg text-white" id="quote" >
          {/* 🌟 CampusLink Logo - Centered */}
          

          <div className="info-content text-center ">
          <img
            src={require("../../images/logo.png")}
            alt="CampusLink Logo"
            className="campus-logo"
          />
            <h2 className="fw-bold">Join Our Community</h2>
            <p>
            Discover vibrant campus events, connect with student communities, and seamlessly manage your event experience—all in one place!
            </p>
          </div>
        </div>

        {/* RIGHT - LOGIN FORM */}
        <div className="col-6 d-flex align-items-center justify-content-center bg-white">
          <div className="card login-card p-4 shadow-lg border-0">
            <h2 className="text-center fw-bold mb-4" id = "IN">Log in</h2>

            {/* 🎯 Role Selection */}
            <div className="mb-3">
              <label className="form-label fw-bold">As:</label>
              <div className="d-flex gap-3">
                <div className="form-check">
                  <input
                    className="form-check-input"
                    type="radio"
                    name="loginType"
                    value="student"
                    checked={role === "student"}
                    onChange={handleRoleSelection}
                  />
                  <label className="form-check-label">Student</label>
                </div>
                <div className="form-check">
                  <input
                    className="form-check-input"
                    type="radio"
                    name="loginType"
                    value="cabinet"
                    checked={role === "cabinet"}
                    onChange={handleRoleSelection}
                  />
                  <label className="form-check-label">Cabinet</label>
                </div>
              </div>
            </div>

            {/* 📧 Email Input */}
            <div className="mb-3">
              <label className="form-label">Email or Username </label>
              <input
                type="email"
                className="form-control"
                placeholder="Enter your email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
            </div>

            {/* 🔒 Password Input */}
            <div className="mb-3">
              <label className="form-label">Password </label>
              <PasswordInput
                id="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>

            {/* 📌 Cabinet-Specific Fields */}
            {role === "cabinet" && (
              <>
                <div className="mb-3">
                  <label className="form-label">Club CRN</label>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Enter club CRN"
                    required
                  />
                </div>
                <div className="mb-3">
                  <label className="form-label">Club Password</label>
                  <PasswordInput id="clubPassword" />
                </div>
              </>
            )}

            {/* Login Button */}
            <button
              type="submit"
              className="btn login-btn w-100"
              onClick={handleSubmit}
            >
              Log In
            </button>

            {/* Forgot Password */}
            <p className="text-center mt-3">
              <Link to="/forgot-password" className="text-muted">
                Forgot password?
              </Link>
            </p>

            {/* Sign Up Link */}
            <p className="mt-3 text-center">
              Don't have an account?{" "}
              <Link to="/signup" className="btn create-btn">
                Sign Up
              </Link>
            </p>

            {/* Error / Success Messages */}
            {message && <p className="text-success text-center">{message}</p>}
            {error && <p className="text-danger text-center">{error}</p>}
          </div>
        </div>
      </div>
    </div>
  );
};

export default LoginForm;
